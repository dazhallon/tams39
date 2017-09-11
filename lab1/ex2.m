% exercise 2

% set variables
xmean = [0.564; 0.603];
S = [0.0144,0.0117;
    0.0117, 0.0146];
Sinv = [203.018, -163.391;
        -163.391, 200.228];
    
n = 42; 
p = length(xmean);

% test H: mean = mu = 0.5*ones(2,1) alpha 0005
alpha = 0.05;
mu = 0.5*ones(2,1);

% create stat.
diff = xmean - mu;

test = n * diff' * Sinv * diff;

T_alpha  = (n-1)*p/(n-p) * finv(1 - alpha, p, n-p);

if T_alpha >= test
    disp('H can not be rejected');
else
    disp('H is rejected in favor of A \neq H');
end

%% create the confidence interval

% create unkown variables mu1 and mu 2

mu =  sym('mu', [2 1], 'real'); 

eq = n .* (xmean - mu)' * Sinv * (xmean - mu ) == T_alpha;

ezplot(eq)

%% compute the simultaneuos Tsquare interval s and the Bonferri interval 
% for \mu_1 and \mu_2 with 95%

% sim. T square
a1 = [1; 0]; a2 = [0;1];
quotient1 = sqrt((a1'*S*a1)/n);
leftbound1 = a1'* xmean - T_alpha * quotient1
righbound1 = a1'* xmean + T_alpha * quotient1

quotient2 = sqrt((a2'*S*a2)/n); 
leftbound2 = a2'* xmean - T_alpha * quotient2
righbound2 = a2'* xmean + T_alpha * quotient2

% Bonferri interval 
tvalue = tinv(1-alpha/2, n-1);

test = n*(xmean(1) - mu(1))*(xmean(1) - mu(1)) / inv(S(1,1))
left_bon_1 = 1;
right_bon_2 = 1;


%%

    
