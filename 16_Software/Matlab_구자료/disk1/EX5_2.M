% The problem will be solved using function program
% rceval
% The output is obtained for the various resistances

c = 10.0e-6;
r1 = 2500;
[v1,t1] = rceval(r1,c);
r2 = 10000;
[v2,t2] = rceval(r2,c);

% plot the voltages
plot(t1,v1,'*w', t2,v2,'+w')
axis([0 1 0 6])
title('Response of an RC circuit to pulse input')
xlabel('Time, s')
ylabel('Voltage, V')
text(0.55,5.5,'* is for 2500 Ohms')
text(0.55,5.0, '+ is for 10000 Ohms')

