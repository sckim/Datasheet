% Junction potential versus source voltage
% using equation(10.36) contact potential is

t = 300; na = 1.0e17; nd = 1.0e14; nisq = 1.0e20;
q = 1.602e-19; k = 1.38e-23;
vc = (k*t/q)*(log(na*nd/nisq));
vs = -1.0:0.1:0.7;
jct_pot = vc - vs;
plot(vs,jct_pot)
title('Junction potential vs source voltage')
xlabel('Source voltage,V')
ylabel('Junction potential,V')
