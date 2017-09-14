% exercise 1.3

sparsepart = [.701 .083 -.012 -.481 21.949 -.494 9.388 .027 .004 34.354];

S_p = symmatrix(sparsepart);

xmean1 = [2.286 16.6 .347 14.83]';
xmean2 = [2.404 7.155 .524 12.840]';

figure(1)
plot(xmean1, 'b'); 
hold on
plot(xmean2, 'r');
legend('Aa bonds', 'Baa bonds')
%% Test H1: C*mu = gamma*1_p (parallel), where C*1 = 0
n = 4;
C = [ones(3,1) -eye(3,3)];

% Set T-square stat. (see lec 6)




%% Test H2|H!: gamma = 0
