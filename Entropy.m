function entropyvalue = Entropy(img)

img = uint8(img);

counts = imhist(img, 256);

total_pixels = sum(counts);

prob = counts / total_pixels;

prob = prob(prob > 0);

entropyvalue = -sum(prob .* log2(prob));
