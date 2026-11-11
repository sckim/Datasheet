% Charging of an RC circuit
%
c = 10e-6;
r1 = 1e3;
tau1 = c*r1;
t = 0:0.002:0.05;
v1 = 10*(1-exp(-t/tau1));

r2 = 10e3;
tau2 = c*r2;
v2 = 10*(1-exp(-t/tau2));

r3 = .1e3;
tau3 = c*r3;
v3 = 10*(1-exp(-t/tau3));

plot(t,v1,'+w',t,v2,'ow', t,v3,'*w')
axis([0 0.06 0 12])
title('Charging of a capacitor with three time constants')
xlabel('Time, s')
ylabel('Voltage across capacitor')
text(0.03, 5.0, '+ for R = 1 Kilohms')
text(0.03, 6.0, 'o for R = 10 Kilohms')
text(0.03, 7.0, '* for R = 0.1 Kilohms')