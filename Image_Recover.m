function [recover_I] = Image_Recover(stego_I,K_en)

[row,col] = size(stego_I); 

rand('seed',K_en); 
E = round(rand(row,col)*255); 
decrypt_I = stego_I;

for i=1:row  
    for j=1:col
        decrypt_I(i,j) = bitxor(stego_I(i,j),E(i,j));
    end
end

Image_Bits = zeros();  
num_TB = 0; 

for pl=8:-1:1
    [Plane] = BitPlanes_Extract(decrypt_I,pl);
    T_Plane = Plane'; 
    PL_bits = reshape(T_Plane,1,row*col); 
    Image_Bits(num_TB+1:num_TB+row*col) = PL_bits;
    num_TB = num_TB+row*col;
end

t = 0; 

transform_code_bits = Image_Bits(t+1:t+3);
t = t+3;

Overflow = zeros(); 
num = ceil(log2(row)) + ceil(log2(col)); 

bin2_num_Of = Image_Bits(t+1:t+num);
t = t+num;
[num_Of] = BinaryConversion_2_10(bin2_num_Of); 

if num_Of>0
    for i=1:num_Of
        bin2_pos = Image_Bits(t+1:t+num);
        t = t+num;
        [pos] = BinaryConversion_2_10(bin2_pos);
        x = ceil(pos/col);
        y = pos - (x-1)*col;
        Overflow(1,i) = x;
        Overflow(2,i) = y;
    end
end

PE_I = decrypt_I;

for pl=8:-1:1
    sign = Image_Bits(t+1);
    t = t+1; 
    
    if sign == 1 
        
        bin2_len = Image_Bits(t+1:t+num); 
        [len_CBS] = BinaryConversion_2_10(bin2_len); 
        t = t+num;
        
        CBS = Image_Bits(t+1:t+len_CBS); 
        t = t+len_CBS;
        
        [Plane_Matrix] = QuadTree_BDBE_DeCompress(CBS, row, col, 1);
        
    else 
        Plane_bits = Image_Bits(t+1:t+row*col); 
        t = t+row*col;
        Plane = reshape(Plane_bits,col,row); 
        Plane_Matrix = Plane'; 
    end
    
    [RI] = BitPlanes_Embed(PE_I,Plane_Matrix,pl);
    PE_I = RI;
end

recover_I = PE_I;
k = 0; 

for i=2:row  
    for j=2:col
        if k<num_Of   
            if i==Overflow(1,k+1) && j==Overflow(2,k+1) 
                k = k+1;
                recover_I(i,j) = PE_I(i,j);
            else
                
                a = recover_I(i-1,j);
                b = recover_I(i-1,j-1);
                c = recover_I(i,j-1);
                
                if b <= min(a,c)
                    pv = max(a,c); 
                elseif b >= max(a,c)
                    pv = min(a,c);
                else
                    pv = a + c - b;
                end
                
                value = PE_I(i,j);
                
                if mod(value,2) == 0 
                    pe = value / 2;
                    recover_I(i,j) = pv + pe;
                else 
                    pe = (value + 1) / 2;
                    recover_I(i,j) = pv - pe;
                end   
            end  
        else
            
            a = recover_I(i-1,j);
            b = recover_I(i-1,j-1);
            c = recover_I(i,j-1);
            
            if b <= min(a,c)
                pv = max(a,c); 
            elseif b >= max(a,c)
                pv = min(a,c);
            else
                pv = a + c - b;
            end
            
            value = PE_I(i,j);
            
            if mod(value,2) == 0 
                pe = value / 2;
                recover_I(i,j) = pv + pe;
            else 
                pe = (value + 1) / 2;
                recover_I(i,j) = pv - pe;
            end 
        end 
    end
end 

recover_I = Image_Inverse_Transform(recover_I, transform_code_bits);
