function [ root ] = recursivexy( img )
    root = findvcuts(img, 1, 1, size(img, 1), size(img, 2));
    %imshow(img == 0);
    %hold on;
    %plotcuts(root, 0);
end

function [node] = findvcuts(img, istart, jstart, ilen, jlen)
    profile = sum(img(istart:istart+ilen-1, jstart:jstart+jlen-1), 1);
    start = 1;
    node = {};
    z = 1;
    for i = 2: size(profile, 2)-1;
        if (profile(i-1) == 0 && profile(i) ~= 0)
            start = i;
        end
        if (profile(i-1) ~= 0 && profile(i) == 0)
            endd = i-1;
            hcuts = findhcuts(img, istart, jstart + start-1, ilen, endd - start + 1);
            node{z} = {istart, jstart + start-1, ilen, endd - start + 1, hcuts};
            z = z+1;
        end
    end;
end

function [node] = findhcuts(img, istart, jstart, ilen, jlen)
    profile = sum(img(istart:istart+ilen-1, jstart:jstart+jlen-1), 2);
    start = 1;
    node = {};
    z = 1;
    for i = 2: size(profile, 1)-1;
        if (profile(i-1) == 0 && profile(i) ~= 0)
            start = i;
        end
        if (profile(i-1) ~= 0 && profile(i) == 0)
            endd = i-1;
            vcuts = findvcuts(img, istart + start-1, jstart, endd - start + 1, jlen);
            node{z} = {istart + start-1, jstart, endd - start + 1, jlen, vcuts};
            z = z+1;
        end
    end;
end

function [] = plotcuts(root, n)
    if n > 1
        return;
    end;
    for i = 1:size(root, 2);
        node = root{i};
        if (size(node{5}, 2) == 0)
            plotvline(node{2}-2);
            plotvline(node{2}-2 + node{4}+3);
            %plothline(node{1} - 2);
            %plothline(node{1} + node{3} + 1);
            
            %ploth
            %rectangle('Position', [node{2}-2, node{1}-2, node{4}+3, node{3}+3]);
        else
            plotcuts(node{5}, n+1);
        end;
    end; 
end
function [] = plotvline(x)
    x = x * ones(1000, 1);
    y = 1:1000;
    plot(x, y);
end
function [] = plothline(y)
    y = y * ones(1000, 1);
    x = 1:1000;
    plot(x, y);
end