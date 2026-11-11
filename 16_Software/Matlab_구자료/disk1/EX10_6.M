% Saturation current
%
t = 25:25:125;
is = 1.0e-15*(1.15).^(t-25);
plot(t,is)
title('Reverse Saturation Current vs. Temperature')
xlabel('Temperature,C')
ylabel('Current, A')

