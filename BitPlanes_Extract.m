function [Plane] = BitPlanes_Extract(I,pl)

[row,col] = size(I);
Plane = zeros(row,col);
index = 8 - pl + 1; 
for i=1:row
    for j=1:col
        value = I(i,j); 
        [bin2_8] = BinaryConversion_10_2(value); 
        Plane(i,j) = bin2_8(index); 
    end
end