% depletion capacitance
%
cj1 = 4.5e-12; vs1 = -10;
cj2 = 6.5e-12; vs2 = -2;
vc = 0.65;
num = cj1/cj2;
den = (vc-vs2)/(vc-vs1);
m = log10(num)/log10(den);
cj0 = cj1*(1 - (vs1/vc))^m;
vs = -30:0.2:0.4;
k = length(vs);
for i = 1:k
 cj(i) = cj0/(1-(vs(i)/vc))^m;
end
plot(vs,cj,'w')
xlabel('Voltage,V')
ylabel('Capacitance,F')
title('Depletion Capacitance vs. Voltage')
axis([-30,2,1e-12,14e-12])