function [exD] = Data_Extract(stego_I,K_hide,num_emD)

Encrypt_exD = zeros();
[row,col] = size(stego_I);

num_exD = 0; 

for pl=1:8 
    if num_exD==num_emD 
        break;
    end
    
    index = 8-pl+1; 
    
    for i=row:-1:1 
        for j=col:-1:1
            if num_exD==num_emD 
                break;
            end
            
            value = stego_I(i,j); 
            [bin2_8] = BinaryConversion_10_2(value); 
            num_exD = num_exD+1;
            Encrypt_exD(num_exD) = bin2_8(index);
        end
    end
end

[exD] = Data_Encrypt(Encrypt_exD,K_hide);