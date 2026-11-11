diary ex4_5.dat
% Program determines the nodal voltages
% 	given an admittance matrix Y and 
%	current vector I
% Initialize matrix Y and the current vector I of
%	matrix equation Y V = I
Y = [-4.4  0.125  -0.125  4.9  0;
     -0.1  0      -0.2    0.55  -0.25;
      0    -0.125  0.325  -0.2   0;
      1    0      -0.6    -0.4   0;
      0    0       0       0     1];
I = [0  0  5  -40  24]';
%  Solve for the nodal voltages 
fprintf('Nodal voltages V(1), V(2), .. V(5) are \n')
V = inv(Y)*I
diary