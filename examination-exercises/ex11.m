% exercise 
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
disp('(a)')
R = corr(X)
%{
The weight and waist size correlates strongly, and the pulse seem to
decrease the smaller the person is. 

What is intresing is that the exercises correltes strongly, but perhaps not
as much as we might first think. 

We can also note that traits for a heavier person (large waist and high weiht)
affect negativeley on all the exercises, wich is most likley becuase they
are body exercises and do not use any weights.
%}

disp('(b)')
S = cov(X);
b1 = 1:3;
b2 = 4:6;
S1 = S(b1,b1);
S2 = S(b2,b2);
S12 = S(b1,b2); 
S21 = S12';
A = inv(S1)*S12*inv(S2)*S21;
B = inv(S2)*S21*inv(S1)*S12;
[Va, da] = eig(A, 'vector');
[Vb, db] = eig(B, 'vector');

R1 = R(b1,b1); R2 = R(b2,b2);
R12 = R(b1, b2); R21 = R(b2, b1);
tmp = inv(sqrtm(R1))*R12*inv(R2)*R21*inv(sqrtm(R1));
[V, d] = eig(tmp, 'vector')
alpha = inv(sqrtm(R1))*V
f = inv(sqrtm(R2))*R21*inv(sqrtm(R1))*V;
b = sqrtm(inv(R2))*f;
for i = 1:size(b,2)
  b(:,i) = b(:,i)/norm(sqrtm(R2)*b(:,i));
end
b
return
% 
% alpha1 = Va(:,max(da) == da)
% beta1 = Vb(:,max(db) == db)
% rho1 = sqrt(max(da))
% 
% alpha2 = Va(:,min(da) == da)
% beta2= Vb(:,min(db) == db)
% rho2 = sqrt(min(da))
% 
% % compute the covariances between the sampe daata an the canonical
% % correlations.
% disp('alpha1*S1')
% printMatrix(alpha1'*S1)
% disp('beta*S2')
% printMatrix(beta1'*S2)
% 


%{
Comment on result here.
%}

disp('(c)')
[n] = size(X,1);
q = 3; p = 3;
% calculate the r-values
A = sqrtm(inv(S1))*S12*sqrtm(inv(S2));
rsqrd= eig(A*A') % alpha
% using corretion by (Fujikoshi, 1977)
for k = 0:2
    logLAMBDA =  sum(log(1 - rsqrd(k+1:end)));
    u = n - k* 0.5*(p + q  + 3) - sum(rsqrd(1:k));
    Q(k+1) = - u * logLAMBDA
    c(k+1) = chi2inv(0.95, (p-k)*(q-k))
    if (Q(k+1) < c(k+1))
        fprintf('For k = %d, we can not reject H, rho_%d to rho_%d are zeros\n',...
            k, k+1, p)
    else
        fprintf('For k = %d, we reject H, rho_%d to rho_%d are not zero\n',...
            k , k+1, p)
    end
end

disp('All exercises are redone but with normalized samples')
Z = zeros(size(X));
for i = 1:size(Z,2)
    Z(:,i) = (X(:,i) - mean(X(:,i)))/sqrt(S(i,i));
end

disp('(a)')
R
Z
R = corr(Z)
%{
We can see that that the new corelation matrix is the same as before.
No comments need to be added.
%}

disp('(b)')
S = cov(Z);
b1 = 1:3;
b2 = 4:6;
S1 = S(b1,b1);
S2 = S(b2,b2);
S12 = S(b1,b2); 
S21 = S12';
A = inv(S1)*S12*inv(S2)*S21;
B = inv(S2)*S21*inv(S1)*S12;
[Va, da] = eig(A, 'vector');
[Vb, db] = eig(B, 'vector');

alpha1 = Va(:,max(da) == da)
beta1 = Vb(:,max(db) == db)
rho1 = sqrt(max(da))

alpha2 = Va(:,min(da) == da)
beta2= Vb(:,min(db) == db)
rho2 = sqrt(min(da))

%{
Add comemnts here
%}

disp('(c)')
[n] = size(Z,1);
q = 3; p = 3;
% calculate the r-values
A = sqrtm(inv(S1))*S12*sqrtm(inv(S2));
rsqrd = eig(A*A') % alpha
logLAMBDA = sum(log(1 - rsqrd(k+1:end)));
% using corretion by (Fujikoshi, 1977)
for k = 0:2
    u = n - k* 0.5*(p + q  + 3) - sum(rsqrd(1:k));
    Q(k+1) = - u * logLAMBDA
    c(k+1) = chi2inv(0.95, (p-k)*(q-k))
    if (Q(k+1) < c(k+1))
        fprintf('For k = %d, we can not reject H, rho_%d to rho_%d are zeros\n',...
            k, k+1, p)
    else
        fprintf('For k = %d, we reject H, rho_%d to rho_%d are not zero\n',...
            k , k+1, p)
    end
end
%{
Intrseting we find that fewer rhos can be set to zero by using
the nomarlized samples.
%}