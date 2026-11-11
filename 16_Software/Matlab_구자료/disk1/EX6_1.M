diary  ex6_1.dat
% This program computes the average power, rms value and
% power factor using quad function. The analytical and 
% numerical results are compared.
% numerical caculations

T = 2*pi/(120*pi); % period of the sin wave
a = 0; % lower limit of integration
b = T; % upper limit of integration
x = 0:0.02:1;
t = x.*b;

v_int = quad('voltage1', a,b);
v_rms = sqrt(v_int/b);  % rms of voltage

i_int = quad('current1',a,b);
i_rms = sqrt(i_int/b);  % rms of current

p_int = quad('inst_pr', a,b);
p_ave = p_int/b;    % average power
pf = p_ave/(i_rms*v_rms); % power factor
%
% analytical solution
%
p_ave_an = (60/2)*cos(30*pi/180);  % average power
v_rms_an = 10.0/sqrt(2);
pf_an = cos(30*pi/180);
% results are printed
fprintf('Average power,analytical %f \n Average power,numerical: %f \n', p_ave_an,p_ave)
fprintf('rms voltage, analytical: %f \n rms voltage,numerical: %f \n', v_rms_an, v_rms)
fprintf('power factor, analytical: %f \n power factor,numerical: %f \n', pf_an, pf)

diary