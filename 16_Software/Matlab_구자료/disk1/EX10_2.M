%
% Electron and hole concentration in a n-type semiconductor
%
nd = logspace(13,18);
n = nd;
ni = 1.52e10;
ni_sq = ni*ni;
p = ni_sq./nd;
semilogx(nd,n,'-',nd,p,'+')
title('Hole concentration')
xlabel('Doping concentration cm-3')
ylabel('Hole Concentration,cm-3')
