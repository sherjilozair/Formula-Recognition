img = imread('eq.png');
img = double(img ~= 0);
root = recursivexy(img);
load 'model';
load 'charnames';
str = translate(img, root, model, true);
fprintf('the formula is %s\n', str);








