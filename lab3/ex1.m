% ex1

X = load('car.dat');   
[n p] = size(X)
[COEFF, SCORE, LATENT, TSQUARED, EXPLAINED, MU] = pca(X)

% use the three first PCs

pc1 = X*COEFF(:,1);
pc2 = X*COEFF(:,2);

C = corr(X, [pc1, pc2])
plot(C(:,1), C(:,2), '*')
for i = 1:p
    text(C(i,1), C(i,2), num2str(i))
end