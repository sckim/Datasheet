diary ex6_5.dat
% Program for poles and zeros
num = [32 224 384 0];
den = [12 92 192 72];
disp('the zeros are')
z = roots(num)
disp('the poles are')
p = roots(den)

% program to evaluate transfer function and
% find the output voltage

s1 = -3+2*j;
n1 = polyval(num,s1);
d1 = polyval(den,s1);
vo = 10.0*exp(j*pi*(40/180))*n1/d1;
vo_abs = abs(vo);
vo_ang = angle(vo)*180/pi;

% print magnitude and phase of output voltage
fprintf('phasor voltage vo, magnitude: %f \n phasor voltage vo, angle in degree: %f', vo_abs, vo_ang)
diary

