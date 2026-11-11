%
% solution of a set of first order differential equations
% the function diff3(t,v) is created to evaluate the
%   differential equation
% the name of the m-file is diff3.m
%
function vdot = diff3(t,v)

vdot(1) = -40*v(1) + 20*v(2) + 20*5;
vdot(2) = 20*v(1) - 20*v(2) - v(3);
vdot(3) = 0.1*v(2) -1000*v(3);
end
