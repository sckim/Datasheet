% Determination of operating point using 
% graphical technique
%
% diode equation
k = 1.38e-23;q = 1.6e-19; 
t1 = 273 + 25; vt = k*t1/q;
v1 = 0.25:0.05:1.1;
i1 = 1.0e-12*exp(v1/(2.0*vt));

% load line 10=(1.0e4)i2 + v2
vdc = 10;
r = 1.0e4;
v2 = 0:2:10;
i2 = (vdc - v2)/r;

% plot
plot(v1,i1,'w', v2,i2,'w')
axis([0,2, 0, 0.0015])
title('Graphical method - operating point')
xlabel('Voltage (V)')
ylabel('Current (A)')
text(0.4,1.05e-3,'Loadline')
text(1.08,0.3e-3,'Diode curve')

