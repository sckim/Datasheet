% solution of a set of first order differential equations
% the function diff3(t,v) is created to evaluate
% the differential equation
% the name of the m-file is diff3.m
%
% Transient analysis of RLC circuit using state
% variable approach

t0 = 0;
tf = 2;
x0 = [0 0 0]; % initial conditions

[t,x] = ode23('diff3', t0, tf, x0);

tt = length(t);

for i = 1:tt
   vo(i) = x(i,1) - x(i,2);
end

plot(t, vo)
title('Transient analysis of RLC')
xlabel('Time, s'), ylabel('Output voltage')
