
function [transformed_I, transform_code] = Image_Transform(I, code)
    [row, col] = size(I);
    transformed_I = I;
    
    switch code
        case 0
            transform_code = [0 0 0];
        case 1
            transform_code = [0 0 1];
            transformed_I = rot90(I, 1);
        case 2
            transform_code = [0 1 0];
            transformed_I = rot90(I, 2);
        case 3
            transform_code = [0 1 1];
            transformed_I = rot90(I, 3);
        case 4
            transform_code = [1 0 0];
            transformed_I = fliplr(I);
        case 5
            transform_code = [1 0 1];
            transformed_I = flipud(I);
    end
end
