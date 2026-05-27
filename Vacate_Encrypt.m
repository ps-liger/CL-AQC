function [ES_I,num_Of,PL_len,PL_room,total_Room,best_code,transform_code_bits] = Vacate_Encrypt(origin_I,K_en)

[row,col] = size(origin_I); 
num = ceil(log2(row))+ceil(log2(col))+3; 

best_code = 0;
min_entropy = Inf;

for code = 0:5
    [transformed_I, ~] = Image_Transform(origin_I, code);
    [PE_I_temp, ~, ~] = Prediction_Error(transformed_I);
    current_entropy = Entropy(PE_I_temp);
    if current_entropy < min_entropy
        min_entropy = current_entropy;
        best_code = code;
    end
end

[transformed_I, transform_code_bits] = Image_Transform(origin_I, best_code);
[PE_I,num_Of,Overflow] = Prediction_Error(transformed_I);

[vacate_I,PL_len,PL_room,total_Room] = Vacate_Room(PE_I,num_Of,Overflow,transform_code_bits);

rand('seed',K_en); 
E = round(rand(row,col)*255); 
encrypt_I = vacate_I;
for i=1:row  
    for j=1:col
        encrypt_I(i,j) = bitxor(vacate_I(i,j),E(i,j));
    end
end

transition_I = encrypt_I;
if total_Room>=num 
    
    bits_room = zeros(1,num);
    bin2_room = dec2bin(total_Room)-'0';
    len = length(bin2_room);
    bits_room(num-len+1:num) = bin2_room;
    
    for i=1:num 
        j = col-num+i; 
        value = transition_I(row,j);
        bit = bits_room(i);
        value_1 = (floor(value/2))*2 + bit;
        transition_I(row,j) = value_1;
    end  
end

ES_I = transition_I;
