
x1 = [191 197 208 180 180 188 210 196 191 179 208 202 200 192 199 ...
    186 197 201 190 209 187 207 178 202 205 190 189 211 216 189 ...
    173 194 198 180 190 191 196 207 209 179 186 174 181 189 188]';
x2 = [284 285 288 273 275 280 283 288 271 257 289 285 272 282 280 ...
    266 285 295 282 305 285 297 268 271 285 280 277 310 305 274 ...
    271 280 300 272 292 286 285 286 303 261 262 245 250 262 258]';
  
%% (a)
mean_male = [190 275]';
alpha = 0.05;
xmean = [mean(x1);mean(x2)];
delta = mean_male - xmean;
X = [x1,x2];
S = cov(X);
n = length(x1); p = length(S);

% set test varialble for Hotelling's T square test
d1 = p; d2 = n-p;
c = (d1*(n-1)) / d2 * finv(1-alpha, d1, d2);
Sinv = inv(S);
T2 = n*delta'*Sinv*delta;
if T2 < c
  disp('We can not reject H0: the same messures holds for females')
else
  disp('Reject H0: mu_female = mu_male')
end

%% (b)
% find the elcispse for 95 % confidence interval
mu =  sym('mu', [2 1], 'real'); 

T_alpha = d2/(d1*(n-1)) *c;

eq = n .* (mean_male - mu)' * Sinv * (mean_male - mu ) == T_alpha;

scale = sqrt(det(S))*0.1;
xmin = mean_male(1) - scale; xmax = mean_male(1) + scale; 
ymin = mean_male(2) - scale; ymax = mean_male(2) + scale;
fig = ezplot(eq, [xmin xmax ymin ymax]);
title('') % remove ugly title
saveas(fig, 'report/images/ellipse-ex1', 'epsc')

%% (c)
% construct the sim. conf. int.
for a = [[1;0], [0;1]];
  a
  int_length = T_alpha*sqrt((a'*S*a)/n);
  lhs = a'*mean_male - int_length
  rhs = a'*mean_male + int_length
end

% Bonferri intervals
c = tinv(1- alpha/4, n-1) % <- obs alpha/4, see Wikipage for Bonferri correction

disp('Here are the two Bonferri intervals for \mu_1 and \mu_2')
for i = [1,2]
  fprintf('For mu_%d\n', i)
  lhs = mean_male(i) - S(i,i)*c/sqrt(n)
  rhs = mean_male(i) + S(i,i)*c/sqrt(n)
end
