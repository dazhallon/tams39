
rho = 0.5;
sigma = 2;
SIGMA = sigma^2 * ((1-rho)*eye(4) + rho * ones(4,4));

mu = [1 2 3 4];

i = 1;
xmean = zeros(4);
S = cell(4,1) ;
for cases = [10 100 1000 10000]
    X = mvnrnd(mu, SIGMA, cases);
    
    xmean(i,:) = (1/cases)*sum(X,1);
    V = X'* (eye(cases) - (1/cases)*ones(cases,cases))*X;
    S{i} =  1/(cases-1) * V;
    i = i+1;
end

% print values 
for i = 1:4
    cases = [10 100 1000 10000];
    n = cases(i);
    fprintf('For %d samples:\n', n);
    disp('xmean')
    disp(xmean(i,:))
    disp('S');
    disp(S{i});
end