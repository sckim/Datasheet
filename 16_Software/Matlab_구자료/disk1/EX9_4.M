% Determination of diode operating point using 
% iterative method
%
k = 1.38e-23;q = 1.6e-19; 
t1 = 273 + 25; vt = k*t1/q;
vdc = 10;
r = 1.0e4;
n = 2;
id(1) = 1.0e-3; vd(1) = 0.7;
reltol = 1.0e-7;

i = 1;
vdiff = 1;
while vdiff > reltol
  id(i+1) = (vdc - vd(i))/r;
  vd(i+1) = vd(i) + n*vt*log(id(i+1)/id(i));
  vdiff = abs(vd(i+1) - vd(i));
  i = i+1;
end

k = 0:i-1;
% operating point of diode is (vdiode, idiode)
idiode = id(i)
vdiode = vd(i)

% Plot the voltages during iteration process
plot(k,vd,'wo')
axis([-1,5,0.6958,0.701]) 
title('Diode Voltage during Iteration')
xlabel('Iteration Number')
ylabel('Voltage, V')
