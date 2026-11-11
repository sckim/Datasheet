diary ex4_4.dat
% This program determines the power dissipated by
% 8 ohm resistor and current supplied by the 
% 10V source
%
% the program computes the loop currents, given
% the impedance matrix Z and voltage vector V
%
% Z is the impedance matrix
% V is the voltage vector
% initialize the matrix Z and vector V of equation
% ZI=V

Z = [26    -20    0;
    -16     41   -6;
     -4     -6   24];
V = [10   5   0]';

% solve for loop currents
I = inv(Z)*V;

% the power dissipation in 8 ohm resistor is P
P = 8*I(3)^2;

% print out the results
fprintf('Power dissipated in 8 ohm resistor is %8.2f Watts\n',P)
fprintf('Current in 10V source is %8.2f Amps\n',I(1))
diary