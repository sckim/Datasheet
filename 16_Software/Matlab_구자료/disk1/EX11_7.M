% Noninverting amplifier with finite CMRR
%
r2 = 50e3; r1 = 1.0e3; rr = r2/r1;
cmrr = logspace(4,9,6);
gain = (1+rr)*(1+1./cmrr);
semilogx(cmrr,gain,'wo')
xlabel('Common-mode Rejection Ratio')
ylabel('Closed-loop Gain')
title('Gain versus CMRR')
axis([1.0e3,1.0e10,50.998, 51.008])
