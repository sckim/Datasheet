diary ex4_3.dat
% this program determines the current
% flowing in a resistor RB and power supplied by source
% it computes the loop currents given the impedance
% matrix Z and voltage vector V
% Z is the impedance matrix
% V is the voltage matrix
% initialize the matrix Z and vector V

Z = [40   -10   -30;
    -10    30    -5;
    -30    -5    65];

V = [10  0  0]';

% solve for the loop currents
I = inv(Z)*V;
% current through RB is calculated
IRB = I(3) - I(2);
fprintf('the current through R is %8.3f Amps \n',IRB)

% the power supplied by source is calculated
PS = I(1)*10;
fprintf('the power supplied by 10V source is %8.4f watts \n',PS)
diary