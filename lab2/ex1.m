% ex1

X1 =  [125 137 121
        144 173 147
        105 119 125
        151 149 128
        137 139 109];

X2 = [ 93   121 107
       116  135 106
       109  83  100
       89   95  83
       116  128 100];
   
x1mean = mean(X1, 1)';
x2mean = mean(X2, 1)';
n1 = 5;
n2 = 5;
plot(x1mean)
hold on
plot(x2mean)
% clearly parallel from images

y = x1mean - x2mean;

C = [ones(2,1), -eye(2,2)];
z = C*y;

S1 = cov(X1);
S2 = cov(X2);
Sp = (S1 + S2)/2;
Sz = C*Sp*C';
f = n1+n2-2;
p = 3;

test = ( f-(p-1)+1 )/( f*(p-1) ) * (n1*n2)/(n1+n2) * ...
       z'*inv(Sz)*z
   
F = finv(1- 0.05, p-1, f-p+2)

% test < F, H holds, they are parallel

% test if they are equal

% Redifne C
n = n1+n2;
k = 2;
%C = [eye(2,2), -ones(2,1)];
A = [ones(n1,1),zeros(n1,1);zeros(n2,1), ones(n2,1)];
X = [X1;X2];
V = X'*(eye(n) - A*inv(A'*A)*A')*X;
C = [eye(2,2), -ones(2,1)];
Y = [x1mean - x2mean];
Cy = [1/n1] + 1/n2* ones(k-1,1)*ones(k-1,1)'
H = Y *inv(Cy) *Y'




lambda = det(C*V*C' + C*H*C')/det(C*V*C')*det(V)/det(V+H)
F = (1- lambda)/lambda

test = (n-k-p+1)/(k-1)*F

c = finv(0.95, k-1, n-k-p+1)

% test is  large, we cant reject h2
xmean = mean(X, 1)';
test = n*xmean'*C'*inv(C*V*C' + C*H*C')*C*xmean

test = (n-p+1)/(p-1)* test
c = finv(0.95, p-1, n-p+1)

% test < c, we can reject h3



