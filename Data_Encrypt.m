function [Encrypt_D] = Data_Encrypt(D,Data_key)

num_D = length(D); 
Encrypt_D = D;  

rand('seed',Data_key); 
E = round(rand(1,num_D)*1); 

for i=1:num_D  
    Encrypt_D(i) = bitxor(D(i),E(i));
end
end