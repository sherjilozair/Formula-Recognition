function [imgr] = edistort(img, sigma, alpha)

%m could also experiment with perlin noise

sz = size(img);
fieldx = 2*rand(sz)-1;
fieldy = 2*rand(sz)-1;

G = fspecial('gaussian', [3*sigma 3*sigma], sigma);

fieldxconv = imfilter(fieldx, G, 'same');
fieldyconv = imfilter(fieldy, G, 'same');

[y, x] = ndgrid(1:sz(1), 1:sz(2));
imgr = interp2(x, y, img, ...
    x+alpha*fieldxconv, y+alpha*fieldyconv);
imgr(isnan(imgr)) = 0;
end

