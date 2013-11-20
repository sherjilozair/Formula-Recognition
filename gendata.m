function [ data ] = gendata(fname, M, height, sz, sigma, alpha)
img = imread(fname);
img = double(img ~= 0);
img = imresize(img, height/max(size(img)));
pad = sz - size(img);
pad = max(pad, 0);
img = padarray(img, floor(pad/2), 0, 'pre');
img = padarray(img, ceil(pad/2), 0, 'post');
data = zeros(M, sz(1)*sz(2));
for i = 1:M;
    imgr = edistort(img, sigma, alpha);
    data(i, :) = reshape(imgr, [1, sz(1)*sz(2)]);
end;
end

