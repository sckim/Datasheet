diary ex9_6.dat
% Capacitance discharge time for smoothing capacitor
% filter circuit
%
vm = 120*sqrt(2);
f0 = 60; r =10e3; c = 100e-6;
t2 = 1/(4*f0);
tperiod = 1/f0;

% use MATLAB function fzero to find the zero of a
% function of one variable

rc = r*c
t3 = fzero('sinexpf1',4.5*t2)
tdis_cap = t3 - t2
fprintf('The value of t2 is %9.5f s\n',t2)
fprintf('The value of t3 is %9.5f s\n',t3)
fprintf('The capacitor discharge time is %9.5f s\n',tdis_cap)
fprintf('The period of input signal is %9.5f s\n',tp)
diary
