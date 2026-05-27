function [cc_h, cc_v, cc_d] = CorrelationCoefficient(img)

img = double(img);
[M, N] = size(img);

x_h = img(:, 1:end-1);
y_h = img(:, 2:end);
cc_h = corrcoef(x_h(:), y_h(:));
cc_h = cc_h(1, 2);

x_v = img(1:end-1, :);
y_v = img(2:end, :);
cc_v = corrcoef(x_v(:), y_v(:));
cc_v = cc_v(1, 2);

x_d = img(1:end-1, 1:end-1);
y_d = img(2:end, 2:end);
cc_d = corrcoef(x_d(:), y_d(:));
cc_d = cc_d(1, 2);
