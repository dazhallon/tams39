% Exercise 6

y1=[0.000,  0.000,  0.000, 22.786, 42.130,  0.000, 12.921,...
  12.921, 18.435,  26.565, 0.000,  0.000,  0.000,  0.000,...
  18.435,  0.000,  0.000, 18.435, 18.435, 36.271,  0.000,...
  0.000,  0.000, 12.921, 33.211]';
y2=[0.000, 18.435, 45.000, 53.729, 90.000, 12.921, 18.435,...
  42.130, 56.789, 67.214,  0.000, 12.921, 22.786, 46.789,...
  67.213,  0.000, 12.921, 42.130, 56.789, 77.079, 12.921,...
  0.000, 39.231, 53.729, 67.213]';
y3=[30.000, 33.211, 60.000, 90.000, 90.000, 26.565, 33.211,...
  77.079, 90.000, 90.000,  0.000, 22.786, 77.079, 77.079,...
  90.000,  0.000, 22.786, 77.079, 90.000, 90.000, 26.565,...
  22.786, 71.565, 90.000, 90.000]';
y4=[30.000, 33.211, 71.565, 90.000, 90.000, 26.565, 33.211,...
  90.000, 90.000, 90.000,  0.000, 30.000, 77.079, 90.000,...
  90.000, 12.921, 26.565, 77.079, 90.000, 90.000, 26.565,...
  30.000, 90.000, 90.000, 90.000]';
y5=[30.000, 33.211, 71.565, 90.000, 90.000, 26.565, 33.211,...
  90.000, 90.000, 90.000, 12.921, 33.211, 77.079, 90.000,...
  90.000, 18.435, 30.000, 77.079, 90.000, 90.000, 26.565,...
  30.000, 90.000, 90.000, 90.000]';
x1=[5.5984, 6.0161, 6.4134, 6.8459, 7.2793, 5.5984, 6.0161,...
  6.4135, 6.8459, 7.2793, 5.5984, 6.0161, 6.4135, 6.8459,...
  7.2793, 5.5984, 6.0161, 6.4135, 6.8459, 7.2793, 5.5984,...
  6.0162, 6.4135, 6.8459, 7.2793]';
x2=[0.6695, 0.6405, 0.7290, 0.7700, 0.5655, 0.7820, 0.8120,...
  0.8215, 0.8690, 0.8395, 0.8615, 0.9045, 1.0280, 1.0445,...
  1.0455, 0.6195, 0.5305, 0.5970, 0.6385, 0.6645, 0.5685,...
  0.6040, 0.6325, 0.6845, 0.7230]';


n = length(y1);
Y = [y1, y2, y3, y4, y5];
X = [ones(n,1), x1, x2];
disp('(a)')
C = [ones(n,1) X];
B = X \ Y
[p q] = size(B)

sigmahat2 = n^-1*(Y - X*B)'*(Y - X*B)

disp('(b) ')
% calculate the sample correlation matrix
R = corr([y1 y2 y3 y4 y5 x1 x2])


disp('some intresting properties is that x1 correlates alot with the y-values')
disp('compared to x2 which correlates very porly. ')
disp('We can also note that we have a strong correlation on the subdiag.')
disp('which indicates that there is som ecorrelation in time.')
disp('We can also note that correlation decreases the futher away the y values ')
disp('are to each other.')
R(1:5 ,end-1:end)

disp('c')

% create the test by creating a matrix C such that the we only look at
% the variables in B concerning x2, i.e B(end, :).

C = zeros(q,p); C(end,end) = 1;
m = size(C,1);

V = Y'*(eye(n) - X*inv(X'*X)*X')*Y
W = B'*C'*pinv(C*inv(X'*X)*C')*C*B % note that we use the penrose psuedo inverse

logLAMBDA = log(det(V)) - log(det(V + W))
f = p*m;
gamma = f * (p^2 + m^2 - 5)/48;
nu = n - (p-m+1)/(2);
z = -(n-1- 0.5*(p-m+1))*logLAMBDA

p = chi2cdf(z, f, 'upper') + (gamma/nu^2)*(chi2cdf(z, f+4, 'upper') - ...
  chi2cdf(z, f, 'upper'))

if (p < 0.05)
  disp('The average weight does not affect the deathrate')
else
  disp('The average weight  does  affect the deathrate')
end

% I think that the avg- weight might affect in an non-linear way.

