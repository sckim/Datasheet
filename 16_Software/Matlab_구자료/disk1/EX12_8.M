%
% Current mirror
%
diary ex12_8.dat
diary on
ucox = 30e-6; l1 = 6e-6; l2 = 6e-6;
w1 = 12e-6; w2=18e-6;
r1=1.5e6; vt=2.0; vdd=5; vout=2.5;

% roots of quadratic Equation(12.103) is obtained
kn = ucox * w1/(2 * l1);
a1 = r1^2;
a2 = -2*(vdd - vt)*r1 - (1/kn);
a3 = (vdd - vt)^2;
p = [a1,a2,a3];
i = roots(p);

% check for realistic value of drain current
vgs=vdd - r1*i(1);
if vgs > vt
	id1 = i(1);
  else
	id1 = i(2);
end

% output current is calculated from equation(12.100)
% r2 is obtained using equation (12.105)
iout = id1*w2*l1/(w1 * l2);
r2=(vdd - vout)/iout;

% print results
fprintf('Gate-source Voltage of T1 is %8.3e Volts\n',vgs)
fprintf('Drain Current of T1 is %8.3e Ampers\n', id1)
fprintf('Drain Current Io is %8.3e Ampers\n', iout)
fprintf('Resistance R2 is %8.3e Ohms\n', r2)