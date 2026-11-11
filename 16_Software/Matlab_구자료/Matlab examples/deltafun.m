function y = deltafun(t,to)
%DELTAFUN  unit delta function.
%
%   Deltafun returns a vector the same length as T with zeros where T ~= T0
%   and ones where T == T0.

%   Soochan Kim
%   Date: 2003/03/18

[m,n] = size(t);
y = zeros(m,n);
i = find(t==to);
if isempty(i)
    return
end
i = i(1);
y(i) = 1;