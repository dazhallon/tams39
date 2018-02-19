% exercise 5
close all; clear;
X = [8  98 7 2 12  8 2;
  7 107 4 3  9  5 3;
  7 103 4 3  5  6 3;
  10  88 5 2  8 15 4;
  6  91 4 2  8 10 3;
  8  90 5 2 12 12 4;
  9  84 7 4 12 15 5;
  5  72 6 4 21 14 4;
  7  82 5 1 11 11 3;
  8  64 5 2 13  9 4;
  6  71 5 4 10  3 3;
  6  91 4 2 12  7 3;
  7  72 7 4 18 10 3;
  10  70 4 2 11  7 3;
  10  72 4 1  8 10 3;
  9  77 4 1  9 10 3;
  8  76 4 1  7  7 3;
  8  71 5 3 16  4 4;
  9  67 4 2 13  2 3;
  9  69 3 3  9  5 3;
  10  62 5 3 14  4 4;
  9  88 4 2  7  6 3;
  8  80 4 2 13 11 4;
  5  30 3 3  5  2 3;
  6  83 5 1 10 23 4;
  8  84 3 2  7  6 3;
  6  78 4 2 11 11 3;
  8  79 2 1  7 10 3;
  6  62 4 3  9  8 3;
  10  37 3 1  7  2 3;
  8  71 4 1 10  7 3;
  7  52 4 1 12  8 4;
  5  48 6 5  8  4 3;
  6  75 4 1 10 24 3;
  10  35 4 1  6  9 2;
  8  85 4 1  9 10 2;
  5  86 3 1  6 12 2;
  5  86 7 2 13 18 2;
  7  79 7 4  9 25 3;
  7  79 5 2  8  6 2;
  6  68 6 2 11 14 3;
  8  40 4 3  6  5 2];


disp('(a) plot the marginal dot diagram for all the variables')

labels = {'Wind', 'Solar radiation', 'CO', 'NO', 'NO_2', '0_3', 'HC'};

p = 6;
fig = figure(1);
hold on
for i = 1:6 
  subplot(2,3,i);
  histogram(X(:,i))
  xlabel(labels{i});
end
hold off

saveas(fig, 'report/images/ex5-marginalplots', 'epsc')

disp('(b) derive the sample mean and sample covarinace')

means = mean(X, 1)
S = cov(X);
% print s in latex format
fprintf('%.2f & %.2f & %.2f & %.2f & %.2f & %.2f & %.2f \n', means)
fprintf('%.2f & %.2f & %.2f & %.2f & %.2f & %.2f & %.2f \\\\ \n', S')


disp('(c) perfom regression analysis using the first respone y1')

% create a linear regression model 
n = size(X,1);
A = [ones(n,1), X(:,1), X(:,2)];
betas = A \ X(:,5)


disp('Analyze the residuals')

y = X(:,5);
x = [ones(n,1), X(:,1:2)];
r = rank(x) - 1
yhat = x*betas;
diff = (y - x*betas);
SSE = diff'*diff
df = n - r - 1;
s = SSE/n;
Rsquared = (yhat'*yhat)/(y'*y)

q = [1 10 80];
ymean = q * betas
k = size(betas, 1);
df = n - k -1;
LHS = ymean - sqrt(s)*tinv(0.975, df)*sqrt(1+q*inv(x'*x)*q');
RHS = ymean + sqrt(s)*tinv(0.975, df)*sqrt(1+q*inv(x'*x)*q');
disp('95 % prediction interval')
fprintf('(%.2f, %.2f)\n', LHS, RHS);
printMatrix([LHS, RHS])

disp('(d) perform a ')

Y = X(:,5:6);
[n m] = size(Y);
A = [ones(n,1), X(:,1:2)];
B = A \ Y;
fprintf('%.2f & %.2f \\\\ \n', B)

disp('Analyze the residuals')
DIFF = Y - A*B;
Yhat = A*B;
DIFF'*DIFF
r = rank(A)- 1; 

SIGMAMLE = (n-r-1)^-1* DIFF'*DIFF
printMatrix(SIGMAMLE)
RSQUARED = (Yhat'*Yhat)./(Y'*Y)
printMatrix(RSQUARED)

disp('Create a confidence elisp')
q = [1 10 80];
ymean = q*B;


mu =  sym('mu', [2 1], 'real'); 
eq = (n-r-m).*  (ymean' - mu)' * inv(SIGMAMLE) * (ymean' - mu ) == ...
  sqrt(1+q*inv(A'*A)*q')*finv(0.95,m,  n-r-m);

scale = sqrt(det(S))*0.01;
xmin = ymean(1) - scale; xmax = ymean(1) + scale; 
ymin = ymean(2) - scale; ymax = ymean(2) + scale;
fig2 = figure(2);
ezplot(eq, [xmin xmax ymin ymax]);
title('') % remove ugly title
xlabel y_1
ylabel y_2
saveas(fig2, 'report/images/ex5-ellipse', 'epsc')

% we can see that the ellispe is covered by 
% the confidence interval in exercise (c), in the y_1 direction. 
