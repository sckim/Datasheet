%
% Diffusion and depletion Capacitances
%
cd1 = 100e-12; id1 = 1.0e-3; cj0 = 8e-12; vc =0.55;
m = 0.5;
is = 1.0e-14; nd = 2.0;
k = 1.38e-23; q = 1.6e-19; T = 300;
kd = cd1/id1;
vt = k*T/q;
v = 0.0:0.05:0.55;
nv = length(v);

for i = 1:nv
 id(i) = is*exp(v(i)/(nd*vt));
 cd(i) = kd*id(i);
 ra(i) = v(i)/vc;
 cj(i) = cj0/((1 - ra(i)).^m);
end

subplot(121)
plot(v,cd)
title('Diffusion Cap.')
xlabel('Voltage, V'), ylabel('Capacitance, F')

subplot(122)
plot(v,cj)
title('Depletion Cap.')
xlabel('Voltage, V'), ylabel('Capacitance, F')

