function [v,t] = rceval(r,c)
% rceval is a function program for calculating
%        the output voltage given the values of 
%        resistance and capacitance.
% usage [v,t] = rceval(r,c)
%       r is the resistance value(ohms)
%       c is the capacitance value(Farads)
%       v is the output voltage
%       t is the time correspondes to voltage v
tau = r*c;
for i=1:50
    t(i) = i/100;
    v(i) = 5*(1-exp(-t(i)/tau));
end

vmax = v(50);

for i = 51:100
    t(i) = i/100;
    v(i) = vmax*exp(-t(i-50)/tau);
end
end