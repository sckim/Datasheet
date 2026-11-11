diary ex9_8.dat
%
% Zener diode voltage regulator
%
vs1 = -30; vs2 = -35; rl =10e3; rs = 2e3;
i = -50e-3: 5e-3 :0;
vz = -20 + 0.05*i;
m = length(i);
i(m+1) = 0; vz(m+1) = -10;
i(m+2) = 0; vz(m+2) = 0;

% loadlines
vt1 = vs1*rl/(rl+rs);
vt2 = vs2*rl/(rl+rs);
rt = rl*rs/(rl+rs);
l1 = vt1/20;
l2 = vt2/20;
v1 = vt1:abs(l1):0;
i1 = (vt1 - v1)/rt;
v2 = vt2:abs(l2):0;
i2 = (vt2 - v2)/rt;

% plots of Zener characteristics, loadlines 
plot(vz,i,'w',v1,i1,'w',v2,i2,'w')
axis([-30,0,-0.03,0.005])
title('Zener Voltage Regulator Circuit')
xlabel('Voltage (V)')
ylabel('Current (A)')
text(-19.5,-0.025,'Zener Diode Curve')
text(-18.6,-0.016, 'Loadline (35 V Source)')
text(-14.7,-0.005,'Loadline (30 V Source)')

% output voltage when vs = -30v
ip1 = (vt1 + 20)/(rt + 0.05)
vp1 = vt1 - rt*(vt1+20)/(rt + 0.05)

% output voltage when vs = -35v
ip2 = (vt2 + 20)/(rt + 0.05)
vp2 = vt2 - rt*(vt2+20)/(rt + 0.05)
diary