% maximum power transfer
% vs is the supply voltage
% rs is the supply resistance
% rl is the load resistance
% vl is the voltage across the load
% pl is the power dissipated by the load

vs = 10;
rs = 10e3;
rl = 0:1e3:50e3;
k = length(rl); % components in vector rl

% Power dissipation calculation
for i=1:k
  pl(i) = ((vs/(rs+rl(i)))^2)*rl(i);
end

% Derivative of power is calculated using backward difference
dp = diff(pl)./diff(rl);
rld = rl(2:length(rl)); % length of rld is 1 less than that of rl

% Determination of Critical points of derivative of power
prod = dp(1:length(dp) - 1).*dp(2:length(dp));
crit_pt = rld(find(prod < 0));
max_power = max(pl); % maximum power is calculated

% print out results
fprintf('Maximum power occurs at %8.2f Ohms\n',crit_pt)
fprintf('Maximum power dissipation is %8.4f Watts\n', max_power)

% Plot power versus load
plot(rl,pl,'+')
title('Power delivered to load')
xlabel('load resistance in Ohms')
ylabel('power in watts')


