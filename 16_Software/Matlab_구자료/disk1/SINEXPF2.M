%
%
function y = sinexpf2(t)
t1 = 1/240; t2 = 2*t1; rc = 10e3*100e-6;
y = 20*sin(120*pi*(t - t2)) - exp(-(t-t1)/rc);
end
