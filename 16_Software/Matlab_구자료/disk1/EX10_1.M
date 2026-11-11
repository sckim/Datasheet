% Electron concentration versus temperature
%
% Calculation of the constant A
diary ex10_1.dat;
k = 8.62e-5; 
na = 1.52e10; ta = 300;
ega = 1.1;
ka = -ega/(k*ta);
t32a = ta.^1.5;
A = na/(t32a*exp(ka));
fprintf('Constant A is %10.5e\n',A)

% Electron Concentration vs. Temperature

for i = 1:10
   t(i) = 273 + 10*(i-1);
   eg(i) = 1.17 - 4.37e-4*(t(i)*t(i))/(t(i) + 636);
   t32(i) = t(i).^1.5;
   ni(i) = A*t32(i)*exp(-eg(i)/(k*t(i)));
end
semilogy(t,ni)
title('Electron Concentration versus Temperature')
xlabel('Temperature, K')
ylabel('Electron Concentration, cm-3')

