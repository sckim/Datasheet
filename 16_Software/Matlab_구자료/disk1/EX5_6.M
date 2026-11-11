% Solution for first order differential equation
% the function diff1(t,y) is created to evaluate
% the differential equation
% Its m-file is diff1.m
%
% Transient analysis of RC circuit using ode 
% function and analytical solution
% numerical solution using ode

t0 = 0;
tf = 20e-3;
xo = 0;  % initial conditions

[t, vo] = ode23('diff1',t0,tf,xo);

% the analytical solution given by equation(5.4) is
vo_analy = 10*(-10*exp(-10*t));

% plot two solutions
subplot(121)
plot(t,vo,'b')
title('State Variable Approach')
xlabel('Time,s')
ylabel('Capacitor Voltage,V')
grid
subplot(122)
plot(t,vo_analy,'b')
title('Analytical Approach')
xlabel('Time,s')
ylabel('Capacitor Voltage,V')
grid

