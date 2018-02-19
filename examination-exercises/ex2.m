%% script for ex2
clear;
x1 = [191 197 208 180 180 188 210 196 191 179 208 202 200 192 199 ...
    186 197 201 190 209 187 207 178 202 205 190 189 211 216 189 ...
    173 194 198 180 190 191 196 207 209 179 186 174 181 189 188]';
x2 = [284 285 288 273 275 280 283 288 271 257 289 285 272 282 280 ...
    266 285 295 282 305 285 297 268 271 285 280 277 310 305 274 ...
    271 280 300 272 292 286 285 286 303 261 262 245 250 262 258]';
 Xf = [x1, x2];
 Sf = cov(Xf);
 
 x1 = [180 186 206 184 177 177 176 200 191 193 212 181 195 187 190 ...
    185 195 183 202 177 177 170 186 177 178 192 204 191 178 177 ...
    284 176 185 191 177 197 199 190 180 189 194 186 191 187 186]'; 
x2 = [278 277 308 290 273 284 267 281 287 271 302 254 297 281 284 ...
    282 285 276 308 254 268 260 274 272 266 281 276 290 265 275 ... 
    277 281 287 295 267 310 299 273 278 280 290 287 286 288 275]';
  x1(x1 == 284) = 184;
  Xm = [x1, x2];
  Sm = cov(Xm);
  
  nf = length(Xf);
  nm = length(Xm);
  n = nm + nf;
  S = (Sm*(nm-1) + Sf*(nf-1))/(n-2);
  M = (n-2)*log(det(S)) - (nm-1)*log(det(Sm)) - (nf-1)*log(det(Sf));
  p = size(Xf,2);
  g = 2;
  u = ((nm-1)^-1 + (nf-1)^-1 - (n-2)^-1)*...
    (2*p^2 + 3*p - 1)/(6*(p+1)*(g-1));
  test = (1-u)*M
  alpha = 0.05;
  C = chi2inv(1- alpha,0.5*p*(p+1)*(g-1))
  disp('reject if test > c')
  
  %%
  y = mean(Xm,1) - mean(Xf, 1);
  y = y';
  T2 = y'*inv((nm^-1+nf^-1)*S)*y
  c2 = (n-2)*p/(n-1-p) *finv(1-alpha, p, n-1-p)
  disp('reject if T2 > c2')
  
  
  
  %% script for ex2
  clear;
  x1 = [191 197 208 180 180 188 210 196 191 179 208 202 200 192 199 ...
    186 197 201 190 209 187 207 178 202 205 190 189 211 216 189 ...
    173 194 198 180 190 191 196 207 209 179 186 174 181 189 188]';
  x2 = [284 285 288 273 275 280 283 288 271 257 289 285 272 282 280 ...
    266 285 295 282 305 285 297 268 271 285 280 277 310 305 274 ...
    271 280 300 272 292 286 285 286 303 261 262 245 250 262 258]';
  Xf = [x1, x2];
  Sf = cov(Xf);
  
 x1 = [180 186 206 184 177 177 176 200 191 193 212 181 195 187 190 ...
    185 195 183 202 177 177 170 186 177 178 192 204 191 178 177 ...
    284 176 185 191 177 197 199 190 180 189 194 186 191 187 186]'; 
x2 = [278 277 308 290 273 284 267 281 287 271 302 254 297 281 284 ...
    282 285 276 308 254 268 260 274 272 266 281 276 290 265 275 ... 
    277 281 287 295 267 310 299 273 278 280 290 287 286 288 275]';
  x2(x1 == 284) = [];
  x1(x1 == 284) = [];
  Xm = [x1, x2];
  Sm = cov(Xm);
  
 nf = length(Xf);
 nm = length(Xm);
 n = nm + nf;
 S = (Sm*(nm-1) + Sf*(nf-1))/(n-2);
 M = (n-2)*log(det(S)) - (nm-1)*log(det(Sm)) - (nf-1)*log(det(Sf));
 p = size(Xf,2);
 g = 2;
 u = ((nm-1)^-1 + (nf-1)^-1 - (n-2)^-1)*...
   (2*p^2 + 3*p - 1)/(6*(p+1)*(g-1));
 test = (1-u)*M
 alpha = 0.05;
 C = chi2inv(1 - alpha,0.5*p*(p+1)*(g-1))
 disp('reject if test > c')
 
 
 %%
 y = mean(Xm,1) - mean(Xf, 1);
 y = y';
 T2 = y'*inv((nm^-1+nf^-1)*S)*y
 c2 = (n-2)*p/(n-1-p) *finv(1-alpha, p, n-1-p)
 disp('reject if T2 > c2')
 
 
 %%
 
% find the elcispse for 95 % confidence interval
mu =  sym('mu', [2 1], 'real'); 
eq = (y - mu)' * inv((nm^-1+nf^-1)*S) * (y - mu ) == c2;

scale = 8;
xmin = y(1) - scale; xmax = y(1) + scale; 
ymin = y(2) - scale; ymax = y(2) + scale;
close all;
fig = figure(1);
hold on
ezplot(eq, [xmin xmax ymin ymax]);
title('');
saveas(fig, 'report/images/ex2fig', 'epsc')

%%

c = sqrt((n-2)*p/(n-1-p) *finv(1-alpha, p, n-1-p));
for a = [[1;0], [0;1]]
  a  
  int_length = c*sqrt((a'*((nf^-1+  nm^-1)*S)*a));
  lhs = a'*y - int_length;
  rhs = a'*y + int_length;
  printMatrix([lhs,rhs])
  if a(1) == 1
    plot(lhs*ones(2,1), [ymin, ymax], 'r')
    plot(rhs*ones(2,1), [ymin, ymax], 'r')
  else
    plot([xmin, xmax], lhs*ones(2,1), 'r')
    plot([xmin, xmax], rhs*ones(2,1), 'r')
  end
end
saveas(fig, 'report/images/ex2fig_with_sim_intervals', 'epsc')
 
