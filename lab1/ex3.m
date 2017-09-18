% exercise 1.3
p = 4; ni = 20;
array1 = [.459 -.254 -.026 -.224 27.465 -.589 -.267 .030 .102 6.854];
array2 = [.944 -.089 .002 -.719 16.432 -.400 19.004 .024 -.094 61.854];

pooled = [.701 .083 -.012 -.481 21.949 -.494 9.388 .027 .004 34.354];

S_1 = symmatrix(array1);
S_2 = symmatrix(array2);
S_p = symmatrix(pooled);

xmean1 = [2.286 16.6 .347 14.83]';
xmean2 = [2.404 7.155 .524 12.840]';

figure(1)
plot(xmean1, 'b'); 
hold on
plot(xmean2, 'r');
legend('Aa bonds', 'Baa bonds')
%% Test if S_1 and S_2 can be pooled into S_p.
% The following test can be found on page 311

alpha = 0.05;

% using LRT with Box's test
u = (2 * p^2 + 3*p - 1) / ( 4*(ni - 1)*(p+1) ) ; 
M = 2*(ni - 1)* log(det(S_p)) - ...
  (ni - 1)*( log(det(S_1)) + log(det(S_2)) ) ;

test =  (1-u)*M
df = 0.5* p* (p + 1)

% C is chi squared with df degrees of freedom
crit_value = chi2inv(alpha, df)

if test <= crit_value
  disp('H can not be rejected, pooling is possible')
else
  disp('H is rejected, the cov. matrices can not be pooled')
end

%% Test H1: C*mu = gamma*1_p (parallel), where C*1 = 0
C = [ones(3,1) -eye(3,3)];

f = 2 * ni -2;

% perfom Hotellings T square on this new variable:
ymean = C*(xmean1 - xmean2);
S_y = C*S_p*C';
T2 = ymean'*inv(S_y)*ymean* (f - p + 2)*(ni^2)/(2*ni*f*(p-1)) ;

c = finv(1 - alpha, p-1, f - p + 2);

if T2 <= c
  disp('H1 can not be rejected, the means are parallel')
else
  disp('H1 is rejected, the means are not parallel')
end




%% Since H1 was rejected, not all means can be equal! 
% Question: Is it enough to sho that the mean vectors aren't parallel,
%           since then they couldn't be equal?

% use the test found in lec 4, slide 33

% create within and between matrices.
xmean = 0.5*(xmean1 + xmean2);
V_w = ni * (xmean1 - xmean)*(xmean1 - xmean)' + ...
  ni* (xmean2 - xmean)*(xmean2 - xmean)';
V_b = (ni - 1) * (S_1 + S_2);

LAMBDA = det(V_w) /  (det(V_w) + det(V_b)); 

logLAMBDA = -2*ni*log(LAMBDA); % is chi-squared with df = ?



% LAMBDA is lambda ditr. with (q, n) degrees of freedmon.

%% Calculate the mean linea combinations tof mean components most responsible 
%  for rejecting H0: mu_1 = mu_2.


a = [0 1 0 0]';

amean = a'*(xmean1- xmean2);

T2_alpha = p*f * finv(1-alpha, p, f-p+1) / (f-p+1);

% create confidence interval

int_length = sqrt(T2_alpha*(2*ni/ni^2)*a'*S_p*a);

lhs = amean - int_length
rhs = amean + int_length

if 0 < lhs || 0 > rhs
  disp(['The confidence confidence interval created by a^T = ', num2str(a)'])
  disp('causes H0 to be rejeceted, since 0 is not in this interval')
end

% since this interval does note include 0 (by a big margin) it is the
% interval that causes H0 to be rejected.


