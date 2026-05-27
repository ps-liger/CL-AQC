function ssimvalue = SSIM(img1, img2)

img1 = double(img1);
img2 = double(img2);

C1 = (0.01 * 255)^2;
C2 = (0.03 * 255)^2;

mu1 = mean2(img1);
mu2 = mean2(img2);

sigma1 = std2(img1);
sigma2 = std2(img2);

cov12 = mean2((img1 - mu1) .* (img2 - mu2));

ssimvalue = ((2*mu1*mu2 + C1)*(2*cov12 + C2)) / ((mu1^2 + mu2^2 + C1)*(sigma1^2 + sigma2^2 + C2));
