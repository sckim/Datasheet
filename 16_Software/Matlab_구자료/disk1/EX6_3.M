diary ex6_3.dat
% This programs calculates the phasor current I1 and
% phasor voltage Va.
% Z is impedance matrix
% V is voltage vector
% I is current vector

Z = [10-7.5*j   -6+5*j;
     -6+5*j   16+3*j];

b = -2*exp(j*pi*75/180);
b
V = [5 b]';  % voltage vector in column form
I = inv(Z)*V; % solve for loop currents
I
i1 = I(1);
i2 = I(2);

Vc = -10*j*(i1 - i2);
i1_abs = abs(I(1));  
i1_ang = angle(I(1))*180/pi;
vc_abs = abs(Vc);
vc_ang = angle(Vc)*180/pi;
%results are printed
fprintf('phasor current i1, magnitude: %f \n phasor current i1, angle in degree: %f \n', i1_abs,i1_ang)
fprintf('phasor voltage Vc, magnitude: %f \n phasor voltage Vc, angle in degree: %f \n',vc_abs,vc_ang)
diary
