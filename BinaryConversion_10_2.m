function [bin2_8] = BinaryConversion_10_2(value)

bin2_8 = dec2bin(value)-'0';
if length(bin2_8) < 8
    len = length(bin2_8);
    B = bin2_8;
    bin2_8 = zeros(1,8);
    for i=1:len
        bin2_8(8-len+i) = B(i); 
    end 
end