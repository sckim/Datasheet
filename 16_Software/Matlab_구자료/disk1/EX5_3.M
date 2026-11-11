% Solution to Example 5.3
% tau1 is time constant when switch is at b
% tau2 is the time constant when the switch is in position
% c
tau1 = 200/100;
for k=1:20
  t(k) = k/20;
  i(k) = 0.4*(1-exp(-t(k)/tau1));
end
imax = i(20);
tau2 = 200/200;
for k = 21:120
  t(k) = k/20;
  i(k) = imax*exp(-t(k-20)/tau2);
end

% plot the current
plot(t,i,'o')
axis([0 6 0 0.18])
title('Current of an RL circuit')
xlabel('Time, s')
ylabel('Current, A')
