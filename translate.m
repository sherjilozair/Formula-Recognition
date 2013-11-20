function [ str ] = translate(img, node, model, horizontal)
if horizontal
    arr = zeros(size(node));
    str = '';
    %size(arr)
    for i = 1:size(arr, 2)
        str = strcat(str, translate2(img, node{i}, model, false));
    end
else
    if size(node, 2) == 3
        top = translate2(img, node{1}, model, true);
        bottom = translate2(img, node{3}, model, true);
        str = strcat(['\frac{', top, '}{', bottom, '}']);
    elseif size(node, 2) == 1
        str = translate2(img, node{1}, model, true);
    end
end

end

function [str] = translate2(img, node, model, horizontal)

if all(size(node{5}) == [0, 0])
    y = node{1} - 2;
    x = node{2} - 2;
    h = node{3} + 4;
    w = node{4} + 4;
    height = 60;
    sz = [64 64];
    img = img(y:y+h, x:x+w);
    img = imresize(img, height/max(size(img)));
    pad = sz - size(img);
    pad = max(pad, 0);
    img = padarray(img, floor(pad/2), 0, 'pre');
    img = padarray(img, ceil(pad/2), 0, 'post');
    x = reshape(img, [1, sz(1)*sz(2)]);
    str = predict([1], sparse(x), model, '-q');
    %figure();
    %imshow(img);
else
    str = translate(img, node{5}, model, horizontal);
end

end

