function uacivalue = UACI(img1, img2)

img1 = double(img1);
img2 = double(img2);

[M, N] = size(img1);

diff = abs(img1 - img2);

uacivalue = sum(diff(:)) / (M * N * 255) * 100;
