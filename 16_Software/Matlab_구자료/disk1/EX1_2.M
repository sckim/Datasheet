diary ex1_2.dat
% Evaluation of Z
% the complex numbers are entered
Z1 = 3+4*j;
Z2 = 5+2*j;
theta = (60/180)*pi;   % angle in radians
Z3 = 2*exp(j*theta);
Z4 = 3+6*j;
Z5 = 1+2*j;
% Z_rect is complex number Z in rectangular form
disp('Z in rectangular form is');% displays text inside brackets
Z_rect = Z1*Z2*Z3/(Z4*Z5);
Z_rect
Z_mag = abs (Z_rect);   % magnitude of Z
Z_angle = angle(Z_rect)*(180/pi);  % Angle in degrees
disp('complex number Z in polar form, mag, phase');% displays text inside brackets
Z_polar = [Z_mag, Z_angle]
diary