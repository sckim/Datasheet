function P1=Ex11_4(x0,y0,x1,y1,x)
%
% Linear Interpolation.
%
% 2001, 12, 28              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

if x0 >= x1
    error('x1은 x0보다 반드시 커야 한다.');
else
    h=x1-x0;
end

r=(x-x0)/h;

if ((r<0) & (r>1))
    error('x값은 x0와 x1사이의 값이어야 한다.');
end
P1=y0+r*(y1-y0);    