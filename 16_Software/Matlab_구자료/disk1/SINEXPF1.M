%
%
function y = sinexpf1(t)
t2 = 1/(4*60);
rc = 10e3*100e-6;
y = sin(120*pi*t) - exp(-(t-t2)/rc);
end
