diary ex6_6.dat
% MATLAB is used to do the partial fraction expansion
%
num = [10 20 40];
den = [1 12 47 60];

% we get the following results

[r, p, k] = residue(num,den)
diary

