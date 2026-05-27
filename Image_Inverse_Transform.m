
function [inverse_transformed_I] = Image_Inverse_Transform(I, transform_code)
    code = BinaryConversion_2_10(transform_code);
    inverse_transformed_I = I;
    
    switch code
        case 0
        case 1
            inverse_transformed_I = rot90(I, 3);
        case 2
            inverse_transformed_I = rot90(I, 2);
        case 3
            inverse_transformed_I = rot90(I, 1);
        case 4
            inverse_transformed_I = fliplr(I);
        case 5
            inverse_transformed_I = flipud(I);
    end
end
