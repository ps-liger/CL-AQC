function [RI] = BitPlanes_Embed(I,Plane,pl)

RI = I;
[row,col] = size(I);   
index = 8 - pl + 1; 
for i=1:row
    for j=1:col
        value = I(i,j); 
        [bin2_8] = BinaryConversion_10_2(value); 
        bin2_8(index) = Plane(i,j); 
        [value] = BinaryConversion_2_10(bin2_8); 
        RI(i,j) = value;
    end
end