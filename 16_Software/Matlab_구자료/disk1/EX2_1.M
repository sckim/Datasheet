% RL circuit
% current i(t) and  voltage v(t) are generated
%  t is time
t = 0:1E-3:20E-3;
v  = 10*cos(377*t);
a_rad = (60*pi/180);  % angle in radians
i = 5*cos(377*t + a_rad);
plot(t,v,'*',t,i,'o')
title('voltage and current of an RL circuit')
xlabel('sec')
ylabel('voltage(V) and current(mA)')
text(0.003, 1.5, 'v(t)');
text(0.009,2, 'i(t)')

