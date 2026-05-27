function [PE_I,num_Of,Overflow] = Prediction_Error(origin_I)

[row,col] = size(origin_I); 
PE_I = origin_I;  
Overflow = zeros(); 
num_Of = 0; 

for i=2:row 
    for j=2:col
        a = origin_I(i-1,j);
        b = origin_I(i-1,j-1);
        c = origin_I(i,j-1);
        
        if b <= min(a,c)
            pv = max(a,c); 
        elseif b >= max(a,c)
            pv = min(a,c);
        else
            pv = a + c - b;
        end
        
        pe = origin_I(i,j) - pv; 
        
        if pe >= -128 && pe <= 127 
            if pe >= 0
                PE_I(i,j) = 2 * pe; 
            else
                PE_I(i,j) = -2 * pe - 1; 
            end
        else
            PE_I(i,j) = origin_I(i,j); 
            num_Of = num_Of+1;
            Overflow(1,num_Of) = i; 
            Overflow(2,num_Of) = j; 
        end  
    end
end