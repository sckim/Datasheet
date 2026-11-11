diary ex9_5.dat
% Baltery charging circuit
%
%
period = 1/60; period2 = period*2;
inc =period/100;
npts = period2/inc;
vb = 11.8;
t = [];
for i = 1:npts
  t(i) = (i-1)*inc;
  vs(i) = 18*sin(120*pi*t(i));
    if vs(i) > vb
     idiode(i) = (vs(i) -vb)/r;
    else
     idiode(i) = 0;
    end
end

subplot(211), plot(t,vs)
%title('Input Voltage')
xlabel('Time (s)')
ylabel('Voltage (V)')
text(0.027,10, 'Input Voltage')

subplot(212), plot(t,idiode)
%title('Diode Current')
xlabel('Time (s)')
ylabel('Current(A)')
text(0.027, 0.7e-3, 'Diode Current')

% conduction angle
theta1 = asin(vb/18); theta2 = pi - theta1;
acond = (theta2 -theta1)/(2*pi)

% peak current
pcurrent = (18*sin(pi/2) - vb)/r

% pcurrent = max(idiode)
diary
