files = {'tex/zero/zero.png'; 
    'tex/one/one.png'; 
    'tex/two/two.png'; 
    'tex/three/three.png'; 
    'tex/four/four.png'; 
    'tex/five/five.png'; 
    'tex/six/six.png'; 
    'tex/seven/seven.png'; 
    'tex/eight/eight.png'; 
    'tex/nine/nine.png'; 
    'tex/lparen/lparen.png'; 
    'tex/rparen/rparen.png';
    'tex/plus/plus.png';
    'tex/minus/minus.png';
    'tex/multiply/multiply.png';};
charnames={'0';'1';'2';'3';'4';'5';'6';'7';'8';'9';'(';')';'+';'-';'*';};
save('charnames', 'charnames');
height = 60;
sz = [64, 64];
sigma = 20;
alpha = 300;
GEN = 0;
GEN2 = 0;
if GEN
    [X, Y] = gendataset(files, charnames, 1000, height, sz, sigma, alpha);
    X = sparse(X);
    save('xtrain', 'X');
    save('ytrain', 'Y');
else
    load('xtrain');
    load('ytrain');
end
model = train(Y, X, '-s 2');
save('model', 'model');
[~, acc, ~] = predict(Y, X, model);
fprintf('training accuracy %f\n', acc);
if GEN2
    [X, Y] = gendataset(files, charnames, 500, height, sz, sigma, alpha);
    X = sparse(X);
    save('xtest', 'X');
    save('ytest', 'Y');
else
    load('xtest');
    load('ytest');
end
    
%[~, acc, ~] = svmpredict(Y, X, model, '-q');
[~, acc, ~] = predict(Y, X, model, '-q');
fprintf('test accuracy %f\n', acc);






