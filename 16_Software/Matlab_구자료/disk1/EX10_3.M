% nc - is doping concentration
%
nc = logspace(14,20);
un = (5.1e18 + 92*nc.^0.91)./(3.75e15 + nc.^0.91);
up = (2.90e15 + 47.7*nc.^0.76)./(5.86e12 + nc.^0.76);

semilogx(nc,un,'w',nc,up,'w')
text(8.0e16,1000,'Electron Mobility')
text(5.0e14,560,'Hole Mobility')
title('Mobility versus Doping')
xlabel('Doping Concentration in cm-3')
ylabel('Bulk Mobility (cm2/v.s)')
