% Exercise 3

% read data
clear; close all;
X1 = [223 242 238;
  72 81 66;
  172 214 239;
  171 191 203;
  138 204 213;
  22 24 24;];
X2 = ...
  [53 102 104;
  45 50 54;
  47 45 34;
  167 188 209;
  183 206 210;
  91 154 152;
  115 133 136;
  32 97 86;
  37 38 40;
  66 131 148;
  210 221 251;
  167 172 212;
  23 18 30;
  234 260 269;];
X3 = ...
  [206 199 237;
  208 222 237;
  224 224 261;
  119 149 196;
  144 169 164;
  170 202 181;
  93 122 145;
  237 243 281;
  208 235 249;
  187 199 205;
  95 102 96;
  46 67 28;
  95 137 99;
  59 76 101;
  186 198 201;];
X4 = ...
  [202 229 232;
  126 159 157;
  54 75 75;
  158 168 175;
  175 217 235;
  147 183 181;
  105 107 92;
  213 263 260;
  258 248 257;
  257 269 270];

disp('(a) plot the profiles')

plots = false;

data = {X1, X2, X3, X4};
mus = zeros(4,3);
if plots
  fig = figure(1);
  hold on
end
n = 0;
for i = 1:4
  mus(i,:) = mean(data{i}, 1);
  if plots
    plot(mus(i,:));
  end
  n = n + size(data{i},1);
  ns(i) = size(data{i},1);
end
if plots
  legend('control','37.5r', '87.5r', '187.5r');
  legend('Location', 'southeast')
end

%%
disp('(b) test if the groups are parallel')
% create covariance matrices
Sp = zeros(3);
for i = 1:4
  S{i} = cov(data{i});
  Sp = Sp + (size(data{i},1)-1)*S{i};
end
Sp = Sp/(n-4);

% we need a test that works for more than two groups
% use the handy function blkdiag to create a block matrix structure
A = blkdiag(ones(ns(1),1), ones(ns(2),1), ones(ns(3),1), ones(ns(4),1));

% create one giant X matrix of all data points
X = cat(1, data{:});
[n,p] = size(X)
k = length(data)

% create the outer matrix
V = X'*(eye(n) - A*inv(A'*A)*A')*X;

Y = mus(1:end-1,:) - mus(end,:);
Y = Y';
CY = diag(1./ns(1:end-1)) - 1/ns(end)*ones(3,3);
CYinv = diag(ns(1:end-1)) - 1/n * ns(1:end-1)*ns(1:end-1)';
C = [ones(2,1), -eye(2,2)];

H = Y*CYinv*Y';

loglambdaH1 = log(det(C*V*C')) - log(det(C*V*C' + C*H*C'));
loglambdaH1 = - loglambdaH1;
u = (n - 0.5*(k + p + 1));
test = -u*loglambdaH1 % test is chi squared with p-1 times k-1
c = chi2inv(.95, (p-1)*(k-1))

if test < c
  disp('The profiles are parellel')
else
  disp('The profiles are not parallel')
end

%%
disp('(c) If the profiles are parallel, test if they are at the same level')
lambda2 = det(C*V*C' + C*H*C')/det(C*V*C') * det(V)/det(V+H);
F = -(1 - lambda2)/lambda2;
test = (n - k - p + 1)/(k - 1) * F % is Fdist with k-1 and n- k - p +1
c = finv(0.95, 4-1, n- k- p +1)

if test < c
  disp('The profiles are on the same level')
else
  disp('The profiles are not on the same level')
end
%%

disp('(d) if the profiles are parallel, test if they are flat')

muhat = mean(mus,1)';
lambda3 =  (1 + n*muhat'*C'*inv(C*V*C' + C*H*C')*C*muhat)^-1;

test = (n - 3 + 1)/(3 - 1) * lambda3

c = finv(0.95, 2, n - 3 + 1)

if test < c
  disp('The profiles are flat')
else
  disp('The profiles are not flat')
end
