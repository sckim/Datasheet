% nc is doping concentration
% rn - resistivity of n-type
% rp - resistivity of p-type

nc = logspace(14,20);
rn = (3.75e15 + nc.^0.91)./(1.47e-17*nc.^1.91 + 8.15e-1*nc);
rp = (5.86e12 + nc.^0.76)./(7.63e-18*nc.^1.76 + 4.64e-4*nc);

semilogx(nc,rn,'w',nc,rp,'w')
axis([1.0e14, 1.0e17,0,140])
title('Resistivity versus Doping')
ylabel('Resistivity (ohm-cm)')
xlabel('Doping Concentration cm-3')
text(1.1e14,12,'N-type')
text(3.0e14,50,'P-type')