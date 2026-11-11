% Slew rate and full-power bandwidth
%
sr = 0.5e6;
v0 = 1.0:10;
fm = sr./(2*pi*v0);
plot(v0,fm)
title('Full-power Bandwidth vs. Rated Output Voltage')
xlabel('Rated output voltage, V')
ylabel('Bandwidth, Hz')
