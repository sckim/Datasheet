diary ex6_4.dat
% This program calculates the phasor voltage of an
% unbalanced three-phase system
% Z is impedance matrix
% V is voltage vector and
% I is current vector

Z = [6+13*j   0         0;
     0        4+2*j     0;
     0        0         6-12.5*j];
c1 = 110*exp(j*pi*(-120/180));
c2 = 110*exp(j*pi*(120/180));
V = [110; c1; c2]; % column voltage vector
I = inv(Z)*V;  % solve for loop currents

% calculate the phase voltages
%
Van = (5+12*j)*I(1);
Vbn = (3+4*j)*I(2);
Vcn = (5-12*j)*(-I(3));

Van_abs = abs(Van);
Van_ang = angle(Van)*180/pi;

Vbn_abs = abs(Vbn);
Vbn_ang = angle(Vbn)*180/pi;

Vcn_abs = abs(Vcn);
Vcn_ang = angle(Vcn)*180/pi;

% print out results
fprintf('phasor voltage Van, magnitude: %f \n phasor voltage Van, angle in degrees: %f \n', Van_abs, Van_ang)

fprintf('phasor voltage Vbn, magnitude: %f \n phasor voltage Vbn, angle in degrees: %f \n', Vbn_abs, Vbn_ang)

fprintf('phasor voltage Vcn, magnitude: %f \n phasor voltage Vcn, angle in degrees: %f \n', Vcn_abs, Vcn_ang)

diary
