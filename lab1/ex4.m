5X = [17.02 10.97 13.24 11.47 9.80 15.44 12.99;
    17.92 13.85 17.23 14.00 12.23 17.38 15.44;
    18.87 11.60 14.13 8.93 8.27 17.73 13.26 ;
    16.75 14.47 15.41 11.78 9.91 15.94 14.04 ;
    18.33 10.78 13.89 14.44 12.11 18.78 14.72];

S = [3.100 .101 -.279 -.083 -.009 1.557;
    .101 5.780 1.013 -.114 -1.014 .039;
    -.279 1.013 5.560 1.039 1.366 -.169;
    -.083 -.114 1.039 5.600 3.080 .258;
    -.009 -1.014 1.366 3.080 6.820 .222;
    1.557 .039 -.169 .258 .222 5.170];
  
  % create test variables
  
  p = size(S, 1) 
  groupmean = X(:,end);
  X = X(:,1:end-1);
  n = 128;
  
  alpha = 0.05
  
  LAMBDA  = p*(p*(p-1))^(p-1)*det(S) / ...
    (sum(S(:))*(p*trace(S) - sum(S(:)))^(p-1));
  
  g = p*(p+1)/2 - 2;
  
  u = n - 1 - p*(p+1)^2*(2*p-3)/(6*(p-1)*(p^2+p-4));
  
  Q = -u*log(LAMBDA)
  
  c = chi2inv(1-alpha, g)
  
  P = chi2cdf(Q, g, 'upper')
  
  if Q >= c
    disp('H is rejected')
  else
    disp('H can not be rejected')
  end
  
  %% Likelihood estimators
  
  sigma = sqrt(trace(S)/(p)) % mean of variances
  
  rho = (sum(S(:)) - trace(S))/((p-1)*trace(S)) % mean of covariances
  
  S_hat = sigma^2*((1-rho)*eye(p,p) + rho*ones(p,p))