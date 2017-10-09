% ex2
clear; clc;
X = load('crime.dat');
[n p] = size(X);

% normalize
S = cov(X);
for i = 1:p
    Z(:,i) = (X(:,i) - mean(X(:,i)))/sqrt(S(i,i));
end
R = corr(Z);
[COEFF, LATENT, EXPLAINED] = pcacov(R)

[V D] = eig(R, 'vector')