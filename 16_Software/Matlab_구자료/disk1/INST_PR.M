function pt = inst_pr(t)
% inst_pr   This function is used to define
%           instantaneous power obtained by multipling
%           sinusoidal voltage and current
it = 6*cos(120*pi*t + 30.0*pi/180);
vt = 10*cos(120*pi*t + 60*pi/180);
pt = it.*vt;
end
