% Solution of second-order differential equation
% The function diff2(x,y) is created to evaluate the 
%   differential equation
% the name of the m-file is diff2.m
% the function is defined as:
%
function xdot = diff2(t,x)

is = 2;
c = 50e-6;  L = 1/32;  r = 10;
k1 = 1/c ; %  1/C 
k2 =  1/L ; %  1/L  
k3 = 1/(r*c); % 1/RC

xdot(1) = k2*x(2);
xdot(2) = k1*is - k1*x(1) - k3*x(2);
end