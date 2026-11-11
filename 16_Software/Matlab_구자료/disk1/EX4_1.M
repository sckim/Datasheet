diary ex4_1.dat
% this programs computes the nodal voltage
% given the admittance matrix and current vector
% Y is the admittance matrix
% I is the current matrix vector
% V is vector
% initialize matrix y and vector I using YV=I form
Y = [ 0.15    -0.1     -0.05;
     -0.1      0.145   -0.025;
     -0.05    -0.025    0.075];
I = [5;
     0;
     2];
% solve for the voltage
fprintf('Nodal voltages V1, V2 and V3 are \n')
v = inv(Y)*I
diary