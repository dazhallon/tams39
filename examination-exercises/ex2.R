# Exercise 3.1
require('R.matlab')
data = readMat('ex2.mat')
x1 = data$x1
x2 = data$x2
n_m = length(x1)
plot(x1,x2,xlab = 'x1',ylab = 'x2')

# an outlier is found at x1 = 284
X = as.matrix(cbind(x1,x2))
S_m = cov(X)

# get the female data
data = readMat('ex1.mat')
x1_f = data$x1
x2_f = data$x2
n_f = length(x1_f)
X_f = as.matrix(cbind(x1_f,x2_f))
S_f = cov(X_f)

n = n_m+n_f
S_p = ((n_m-1)*S_m + (n_f-1)*S_f)/(n-2)
p =2

# Test found in book at page 331
# using LRT with Box's test
f_m = n_m -1; f_f = n_m -1;
f = f_m + f_f;
u = (1/(n_f-1) + 1/(n_m - 1) - 1/(f_m + f_f))*(2 * p^2 + 3*p - 1) / ( 6*(p+1) ) ; 
M = f* log(det(S_p)) - 
  (f_m*log(det(S_m)) + f_f*log(det(S_f)) ) ;

test = (1-u)*M
print(test)
df = 0.5* p* (p + 1)

# C is chi squared with df degrees of freedom
c = qchisq(0.05, df)
print(c)

if(test<=c){
 print('Pooling is possible') 
}else{
 print('Polling is not possible') 
}

# (c)
# remove the outlier found at x1 = 284
where = x1 %in% 284
x1 = x1[!where]
x2 = x2[!where]
X_m = as.matrix(cbind(x1,x2))
mean(X_m)
male_mean = colMeans(X_m)

female_mean = colMeans(X_f)

# update the pooled matrix
n_m = length(x1)
n = n_m+n_f
S_p = ((n_m-1)*S_m + (n_f-1)*S_f)/(n-2)

delta = male_mean - female_mean
test = n_f*n_m*t(delta)%*%solve(S_p)%*%delta/
  (n_f+n_m)
print(test)
f = n - 2
c = f*p*qf(1-0.05, p, f-p+1)/(f-p+1)
print(c)
if (test < c){
  print('cannot reject H')
}else{
  print('reject H')
}

# (e) 
# determine the 95 % confidence region 

# determine the compentwise conf. intervals
a = c(1,0)
delta = as.vector(delta)

center = a %*% delta
length = test* (a %*% S_p %*% a) / sqrt(n)

LHS = center - length;
RHS = center + length;

# print the intervals
print(c('(',LHS, RHS, ')'))

# something seems a  bit of...
# should review this entire exercise (perhaps
# even re do them i matlab 
# (since some code as already been done
# there))


