% exercise 10
clear; close all;
R = [1  0.615  -.111 -.266 1  -.019 -.085  1 -0.269 1];
R = symmatrix(R) % this my own function!
disp('(a)')
b1 = 1:2;
b2 = 3:4;
R1 = R(b1,b1);
R2 = R(b2,b2);
R12 = R(b1,b2); 
R21 = R12';
A = inv(R1)*R12*inv(R2)*R21;
B = inv(R2)*R21*inv(R1)*R12;
[Va, da] = eig(A, 'vector');
[Vb, db] = eig(B, 'vector');

alpha1 = Va(:,max(da) == da)
beta1 = Vb(:,max(db) == db)
rho1 = sqrt(max(da))

alpha2 = Va(:,min(da) == da)
beta2= Vb(:,min(db) == db)
rho2 = sqrt(min(da))

disp('(b)')
