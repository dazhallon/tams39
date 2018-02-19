
clear; close all; clc
X = [191  36  50   5  162   60;
  189  37  52   2  110   60;
  193  38  58  12  101  101;
  162  35  62  12  105   37;
  189  35  46  13  155   58;
  182  36  56   4  101   42;
  211  38  56   8  101   38;
  167  34  60   6  125   40;
  176  31  74  15  200   40;
  154  33  56  17  251  250;
  169  34  50  17  120   38;
  166  33  52  13  210  115;
  154  34  64  14  215  105;
  247  46  50   1   50   50;
  193  36  46   6   70   31;
  202  37  62  12  210  120;
  176  37  54   4   60   25;
  157  32  52  11  230   80;
  156  33  54  15  225   73;
  138  33  68   2  110   43];
[n m] = size(X)
Z = (X - ones(n,1)*mean(X, 1))./sqrt(ones(n,1)*diag(cov(X))')
R = cov(Z);
S = R
%%
disp('(a)')
%{
The weight and waist size correlates strongly, and the pulse seem to
decrease the smaller the person is. 

What is intresing is that the exercises correltes strongly, but perhaps not
as much as we might first think. 

We can also note that traits for a heavier person (large waist and high weiht)
affect negativeley on all the exercises, wich is most likley becuase they
are body exercises and do not use any weights.
%}

%%
disp('(b)')
b1 = 1:3;
b2 = 4:6;
S1 = S(b1,b1);
S2 = S(b2,b2);
S12 = S(b1,b2); 
S21 = S12';
A = inv(sqrtm(S1))*S12*inv(S2)*S21*inv(sqrtm(S1));
B = inv(sqrtm(S2))*S21*inv(S1)*S12*inv(sqrtm(S2));
[Va, da] = eigs(A);
[Vb, db] = eigs(B);
rho = diag(sqrt(da));
[~, order] = sort(rho, 'descend');
rho = rho(order)
Va = Va(:, order) 
Vb = Vb(:, order)
alpha = inv(sqrtm(S1))*Va
for i = 1:3
  printMatrix(alpha(:,i))
end
beta = inv(sqrtm(S2))*Vb
for i = 1:3
  printMatrix(beta(:,i))
end

%%
disp('(c)')
[n] = size(Z,1);
q = 3; p = 3;
Q = zeros(1,q);
c = zeros(1,q);
% Test according to equation 10-41 (p 565)
for k = 0:2
    logLAMBDA =  sum(log(1 - rho(k+1:end).^2));
    u = n - 1 - k* 0.5*(p + q  + 1);
    Q(k+1) = - u * logLAMBDA
    c(k+1) = chi2inv(0.95, (p-k)*(q-k))
    if (Q(k+1) <=  c(k+1))
        fprintf('For k = %d, we can not reject H, rho_%d to rho_%d are zeros\n',...
            k, k+1, p)
    else
        fprintf('For k = %d, we reject H, rho_%d to rho_%d are not zero\n',...
            k , k+1, p)
    end
end

printMatrix([0:2; Q; c; Q <= c]')