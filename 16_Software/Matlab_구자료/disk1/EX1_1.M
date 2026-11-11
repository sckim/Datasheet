diary  ex1_1.dat
% diary causes output to be written into file ex1_1.dat
% Voltage and power calculation

R=10;       % Resistance value
i=(0:2:10); % Generate current values
v=i.*R;      % array multiplication to obtain voltage
p=(i.^2)*R;  % power calculation
sol=[i v p]  % current, voltage and power values are printed
diary
% the last diary command turns off the diary state