diary ex9_7.dat
% Full-wave rectifier

%
period = 1/60;
t1 = period/4
vripple = 20/(2*60*10e3*100e-6);
vdc = 20 - vripple/2
t3 = fzero('sinexpf2',0.7*period)
tdis_cap = t3 - t1;
fprintf('Ripple value (peak-peak) is %9.5f V\n',vripple)
fprintf('DC output voltage is %9.5f V\n',vdc)
fprintf('The capacitor discharge time is %9.5f s\n',tdis_cap)
fprintf('Period of ripple voltage is %9.5f s\n',0.5*period)
diary
