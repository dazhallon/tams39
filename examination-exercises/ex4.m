% exercise 4
disp('(a) test if the covariance matrices can be pooled')
% create covariance matrices, and create the pooled matrix
k = 3;
p = size(data{1}, 2);
ns = zeros(k,1);
S = cell(k,1);
Sp = zeros(p,p);
for i =1:k
  S{i} = cov(data{i});
  ns(i) =  size(data{i},1);
  fs(i) = ns(i) -1;
  Sp = Sp + (ns(i) -1)*S{i};
  means(i) = mean(data{i}, 1);
end
n = sum(ns);
f = sum(fs);
Sp = Sp/(n-1);

% create V matrices
Vs = cell(k,1);
V = zeros(p,p);
for i = 1:k
  Vs{i} = data{i}*(eye(ns(i)) - ns(i)^-1*ones(ns(1)));
  V = V + Vs{i};
end 


lambdastar  = prod(Vs{:}.^(fs(:)/2)) / det(V)^(f/2) ...
  * f^(p*f/2) / prod(fs(:).^(p*fs(:)/2));

df = 0.5*p*(p+1)*(k-1);
alpha = 0;
for i = 1:k
  alpha = alpha + f/fs(i );
end
alpha  = alpha -1;
alpha = alpha * (2*p^2 + 3*p - 1)/(12*(p+1)*(k-1));
m = f- 2*alpha;

test = -2*f^-1 * m *log(lambdastar);

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

if i = 1:k
  ls(i,:) = means(i) * invSp
  c(i) = -0.5*means(i)'*invSp*means(i);
end

x0 = zeros(p,1);

class = 1;

L = @(x, l, c) l * x + c;
max = L(x0, ls(1), c(1));
for i = 2:k
  tmp = L(x0, ls(i) c(i));
  if tmp > max
    max = tmp;
    class = i;
  end
end

disp(['We can classify x0 as ', num2str(i)]);

disp('(c) Estimate the errors of misclassification of ')

% how to estimate the errors whem we have three classes.instead
% of just 2?
% Assume that the third class is not there, and carry on with the
% calculations a sif there was just two classes?
