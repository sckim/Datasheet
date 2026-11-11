diary ex4_2.dat
% this program computes the nodal voltages
% given the admittance matrix Y and current vector I
% Y is the admittance matrix
% I is the current vector
% initialize the matrix y and vector I using YV=I

Y = [0.75   -0.2   0   -0.5;
       -5      1  -1      5;
     -0.2   0.45  0.166666667   -0.0666666667;
        0      0   0      1];

% current vector is entered as a transpose of row vector
I = [5   0   0   10]';

% solve for nodal voltage
fprintf('Nodal voltages V1,V2,V3,V4 are \n')
V = inv(Y)*I
diary