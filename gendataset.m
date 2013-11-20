function [X, Y] = gendataset(files, charnames, M, height, sz, sigma, alpha)

X = zeros(size(files, 1)*M, sz(1)*sz(2));
Y = zeros(size(files, 1)*M, 1);
for i = 1: size(files, 1);
    fprintf('\tfor file %d\n', i);
    X(M*(i-1)+1:M*i, :) = gendata(files{i}, M, height, sz, sigma, alpha);
    Y(M*(i-1)+1:M*i) = charnames{i};
end;
end

