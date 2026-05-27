
function [description] = GetTransformDescription(code)
    
    switch code
        case 0
            description = '无变换 (原始)';
        case 1
            description = '逆时针旋转 90 度';
        case 2
            description = '旋转 180 度';
        case 3
            description = '逆时针旋转 270 度 (顺时针 90 度)';
        case 4
            description = '水平翻转';
        case 5
            description = '垂直翻转';
        otherwise
            description = '未知变换';
    end
end
