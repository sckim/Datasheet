function req = equiv_sr(r)
% equiv_sr is a function program for obtaining
%             the equivalent resistance of series  
%             connected resistors
% usage:  req = equiv_sr(r)
%               r is an input vector of length n
%               req is an output, the equivalent resistance(scalar)
%
%
n = length(r);    % number of resistors
req = sum (r);    % sum up all resistors
end

