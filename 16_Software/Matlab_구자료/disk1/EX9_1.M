diary ex9_1.dat
% Diode  parameters

vt = 25.67e-3;
v = [0.1 0.2 0.3 0.4 0.5 0.6 0.7];
i = [0.133e-12 1.79e-12 24.02e-12 321.66e-12 4.31e-9 57.69e-9 772.58e-9];

% Plot i-v characteristics
lni = log(i); % Natural log of current

% Coefficients of Best fit linear model is obtained
p_fit = polyfit(v,lni,1);

% linear equation is   y = m*x + b
b = p_fit(2);
m = p_fit(1);
ifit = m*v + b;

% Calculate Is and n
Is = exp(b)
n = 1/(m*vt)

% Plot v versus ln(i), and best fit linear model
plot(v,ifit,'w', v, lni,'ow')
axis([0,0.8,-35,-10])
xlabel('Voltage (V)')
ylabel('ln(i)')
title('Best fit linear model')

diary