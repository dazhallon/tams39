% exercise

clear; close all;
% Observe that this is not the full sample correlation matrix
R = [1 .54 .44 .33 .19 .14 .22 .22 .05 .33 .25 .24 .14 .24 .28;
  0 1 .49 .28 .18 .14 .21 .19 .00 .32 .23 .19 .13 .19 .23;
  0 0 1 .29 .23 .19 .26 .27 .06 .24 .29 .23 .21 .23 .30;
  0 0 0 1 .12 .15 .23 .23 .06 .24 .19 .21 .13 .21 .24;
  0 0 0 0 1 .54 .25 .26 .18 .32 .28 .16 .09 .18 .28;
  0 0 0 0 0 1 .24 .23 .17 .24 .20 .17 .12 .18 .24;
  0 0 0 0 0 0 1 .33 .13 .35 .27 .25 .25 .27 .43;
  0 0 0 0 0 0 0 1 .21 .37 .32 .40 .30 .40 .50;
  0 0 0 0 0 0 0 0 1 .17 .17 .09 .12 .14 .26;
  0 0 0 0 0 0 0 0 0 1 .59 .25 .25 .32 .45;
  0 0 0 0 0 0 0 0 0 0 1 .24 .23 .25 .36;
  0 0 0 0 0 0 0 0 0 0 0 1 .21 .31 .32;
  0 0 0 0 0 0 0 0 0 0 0 0 1 .48 .38;
  0 0 0 0 0 0 0 0 0 0 0 0 0 1 .50;
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
p = length(R);
R = R' + R - eye(p);

%{
For any k, whe still have that p = length(R), which is fixed. However,
according to the book in the begning of Chapter 9, the model will look
fairly general, but know with only k bwing free to change value, i.e.,
changing the number of common factors assumed in the model.
%}

disp('(b)')
% we might just study the pca of the covariance matrix as in the book, or
% we may simply use the formula found on slide 29 on lecture 10
upper_limit_k = 0.5*((2*p+1)-sqrt(8*p+1));
fprintf('We should at least choose k s.t. k <= %d\n', upper_limit_k)


[COEFF, LATENT, EXPLAINED] = pcacov(R)
%{
according to the upper limit, we should choose k at most 10. If we perfrom
and PCA on R, we find that we need alot oc PC's to explained most of the
variance. We find that we need the 10 first PC's to cover 85%.
%}
% let go with k = 10
k = 3;

[Lambda,Psi,T] = factoran(R,k,'xtype','cov')
SIGMA = Lambda*Lambda' + diag(Psi);
logLRT = log(det(R)) - log(det(SIGMA));
g = 0.5*((p-k)^2 - (p+k));
n = 210; 
u = n - (2*p+4*k+11)/6;
Q = -u *logLRT
c = chi2inv(0.95, g)

if (Q <c)
  fprintf('We cannot reject H, the number of k = %d chosen is adequate\n',...
    k)
else
  fprintf('We reject H, the number of k = %d chosen is not adequate\n',...
    k)
end
% for k = 10, g = 0 and so it is impossoible for the test to pass. However
% we can use k = 9, and 