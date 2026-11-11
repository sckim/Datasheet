% Temperature effects on diode characteristics
%
k = 1.38e-23; q = 1.6e-19;
t1 = 273 + 0;
t2 = 273 + 100;

ls1 = 1.0e-12;
ks = 0.072;
ls2 = ls1*exp(ks*(t2-t1));

v = 0.45:0.01:0.7;
l1 = ls1*exp(q*v/(k*t1));
l2 = ls2*exp(q*v/(k*t2));

plot(v,l1,'wo',v,l2,'w+')
axis([0.45,0.75,0,10])
title('Diode I-V Curve at two Temperatures')
xlabel('Voltage (V)')
ylabel('Current (A)')
text(0.5,8,'o is for 100 degrees C')
text(0.5,7, '+ is for 0 degree C')

