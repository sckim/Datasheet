% solution of second order differential equation
% the function diff2(x,y) is created to evaluate
% the differential equation
% the name of m-file is diff2.m
%
% Transient analysis of RLC circuit using ode function
% numerical solution

t0 = 0; 
tf = 30e-3;
x0 = [0 20]; % Initial conditions
[t,x] = ode23('diff2',t0,tf,x0);

% Second column of matrix x represent capacitor voltage
subplot(211), plot(t,x(:,2))
xlabel('Time, s'), ylabel('Capacitor voltage, V')
text(0.01, 7, 'State Variable Approach')

% Transient analysis of RLC circuit from Example 5.5
t2 =0:1e-3:30e-3;
vt = -6.667*exp(-1600*t2) + 26.667*exp(-400*t2);
subplot(212), plot(t2,vt)
xlabel('Time, s'), ylabel('Capacitor voltage, V')
text(0.01, 4.5, 'Results from Example 5.5')