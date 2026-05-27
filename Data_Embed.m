function [stego_I,emD] = Data_Embed(ES_I,K_hide,D)

[row,col] = size(ES_I); 

num = ceil(log2(row))+ceil(log2(col))+3; 
bits_room = zeros(1,num); 

for i=1:num  
    j = col-num+i; 
    value = ES_I(row,j);
    bit = mod(value,2);
    bits_room(i) = bit;
end

[total_Room] = BinaryConversion_2_10(bits_room);

[encrypt_D] = Data_Encrypt(D,K_hide);

marked_I = ES_I;
num_D = length(D);
num_emD = 0; 

for pl=1:8 
    if num_emD==num_D || num_emD==total_Room 
        break;
    end
    
    index = 8-pl+1; 
    
    for i=row:-1:1  
        for j=col:-1:1
            if num_emD==num_D || num_emD==total_Room 
                break;
            end
            
            value = marked_I(i,j); 
            [bin2_8] = BinaryConversion_10_2(value); 
            num_emD = num_emD+1;
            bin2_8(index) = encrypt_D(num_emD); 
            [value] = BinaryConversion_2_10(bin2_8);
            marked_I(i,j) = value; 
        end
    end
end

stego_I = marked_I;

emD = D(1:num_emD);