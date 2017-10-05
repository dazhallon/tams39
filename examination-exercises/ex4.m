				% exercise 4

%% read data
%  Ch. Concinna
X1 = [191  131  53  150  15  104;
    185  134  50  147  13  105;
    200  137  52  144  14  102;
    173  127  50  144  16  97;
    171  118  49  153  13  106;
    160  118  47  140  15  99;
    188  134  54  151  14  98;
    186  129  51  143  14  110;
    174  131  52  144  14  116;
    163  115  47  142  15  95;
    190  143  52  141  13  99;
    174  131  50  150  15  105;
    201  130  51  148  13  110;
    190  133  53  154  15  106;
    182  130  51  147  14  105;
    184  131  51  137  14  95;
    177  127  49  134  15  105;
    178  126  53  157  14  116;
    210  140  54  149  13  107;
    182  121  51  147  13  111;
    186  136  56  148  14  111];

%  Ch. Heikertlinger
X2= [186  107  49  120  14  84;
    211  122  49  123  16  95;
    201  114  47  130  14  74;
    242  131  54  131  16  90;
    184  108  43  116  16  75;
    211  118  51  122  15  90;
    217  122  49  127  15  73;
    223  127  51  132  16  84;
    208  125  50  125  14  88;
    199  124  46  119  13  78;
    211  129  49  122  13  83;
    218  126  49  120  15  85;
    203  122  49  119  14  73;
    192  116  49  123  15  90;
    195  123  47  125  15  77;
    211  122  48  125  14  73;
    187  123  47  129  14  75;
    192  109  46  130  13  90;
    223  124  53  129  13  82;
    188  114  48  122  12  74;
    216  120  50  129  15  86;
    185  114  46  124  15  92;
    178  119  47  120  13  78;
    187  111  49  119  16  66;
    187  112  49  119  14  55;
    201  130  54  133  13  84;
    187  120  47  121  15  86;
    210  119  50  128  14  68;
    196  114  51  129  14  86;
    195  110  49  124  13  89;
    187  124  49  129  14  88];

% Ch. Heptapatamica
X3 = [158  141  58  145  8   107;
    146  119  51  140  11  111;
    151  130  51  140  11  113;
    122  113  45  131  10  102;
    138  121  53  139  11  106;
    132  115  49  139  10  98;
    131  127  51  136  12  107;
    135  123  50  129  11  107;
    125  119  51  140  10  110;
    130  120  48  137  9   106;
    130  131  51  141  11  108;
    138  127  52  138  9   101;
    130  116  52  143  9   111;
    143  123  54  142  11  95;
    154  135  56  144  10  123;
    147  132  54  138  10  102;
    141  131  51  140  10  106;
    131  116  47  130  9   102;
    144  121  53  137  11  104;
    137  146  53  137  10  113;
    143  119  53  136  9   105;
    135  127  52  140  10  108];

data = {X1, X2, X3};
disp('(a) test if the covariance matrices can be pooled')
% create covariance matrices, and create the pooled matrix
k = 3;
p = size(data{1}, 2);
ns = zeros(k,1);
S = cell(k,1);
Sp = zeros(p,p);
means = zeros(p, k);
for i =1:k
  S{i} = cov(data{i});
  ns(i) =  size(data{i},1);
  fs(i) = ns(i) -1;
  Sp = Sp + (ns(i) -1)*S{i};
  means(:,i) = mean(data{i}, 1);
end
n = sum(ns);
f = sum(fs);
Sp = Sp/(n-1);

% create V matrices
Vs = cell(k,1);
V = zeros(p,p);
for i = 1:k
  Vs{i} = data{i}'*(eye(ns(i)) - ns(i)^-1*ones(ns(i)))*data{i};
  V = V + Vs{i};
end 


loglambdastar  = (p*f/2)*log(f) - (f/2)*log(det(V));
for i = 1:k
  loglambdastar  = loglambdastar + (fs(i)/2)*log(det(Vs{i})) ...
    - (p*fs(i)/2)*log(fs(i));
end
df = 0.5*p*(p+1)*(k-1);
alpha = 0;
for i = 1:k
  alpha = alpha + f/fs(i );
end
alpha  = alpha - 1;
alpha = alpha * (2*p^2 + 3*p - 1)/(12*(p+1)*(k-1));
m = f- 2*alpha;

test = -2*f^-1 * m * loglambdastar

c = chi2inv(0.95, df)

if test < c
  disp('The covariance matrices can be pooled')
else
  disp('The covariance matrices can not be pooled')
end


disp('(b) Derive the classification rule for these data')
 % using FLD we can find the linear classification rules.
 % this is done by finding the lines that maxmimizes the noem from each
 % data set.

ls = zeros(k, p);
invSp = inv(Sp);

fprintf('The linear separation obatined\n')
for i = 1:k
  ls(i,:) = means(:,i)' * invSp;
  c(i) = -0.5*means(:,i)'*invSp*means(:,i);
  fprintf('l_%d^T x_0 + c_%d = (%.2f, %.2f, %.2f, %.2f, %.2f, %.2f)x_0 + %.2f \\\\ \n', ...
    i,i,ls(i,:)', c(i))
end


x0 = zeros(p,1);

class = 1;

L = @(x, l, c) l * x + c;
max = L(x0, ls(1), c(1));
for i = 2:k
  tmp = L(x0, ls(i), c(i));
  if tmp > max
    max = tmp;
    class = i;
  end
end
disp(['example: x0 = ', num2str(x0')])
disp(['We can classify x0 as pi_', num2str(i)]);

disp('(c) Estimate the errors of misclassification of... ')

delta = means(:,1) - means(:,2);

% should we use the pooled matrix for pi1 and pi2, or the collective for
% all?
pooled12 = ((ns(1)-1)*cov(data{1}) + (ns(2)-1)*cov(data{2}))...
  /(ns(1) + ns(2) - 2);
%K = 0.5*delta'*inv(pooled12)*(means(:,1) + means(:,2));
Delta = sqrt(delta'*inv(pooled12)*delta);
%Delta = sqrt(delta'*inv(Sp)*delta);
% Get different result using the spooled matrix from earlier. 
% However, the difference between e1 and e2 is virtually 0.

a1 = normpdf(Delta)*(Delta^2 + 12*(p-1)) / (16*Delta);
a2 = normpdf(Delta)*(Delta^2 - 4*(p-1)) / (16*Delta);

disp('Misscalsifaction into pi1')
e1 = normpdf(-0.5*Delta) + a1/ns(1) + a2/ns(2)

disp('Misscalsifcation into pi2')
e2 = normpdf(-0.5*Delta) + a2/ns(1) + a1/ns(2)

% comment: Delta gets very large and so nompdf(Delta) becomes so small that
% a1 and a2 are virtualy 0, implying e1 and e2 is virtually the same, 
% which might not be wrong by any stretch.

