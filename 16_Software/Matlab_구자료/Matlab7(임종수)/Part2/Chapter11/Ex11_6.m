function P2=Ex11_6(x0,y0,x1,y1,x2,y2,x)
%
% Quadratic Interpolation.
%
% 2001, 12, 28              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

if sort([x0, x1, x2]) ~=  ([x0, x1, x2])
    error('x0, x1, x2의 순으로 값이 커져야 한다.');
else
    h=x1-x0;
end

r=(x-x0)/h;

if ((r<0) & (r>2))
    error('x값은 x0와 x2사이의 값이어야 한다.');
end

P2=y0+r*(y1-y0)+((r*(r-1))/2)*((y2-y1)-(y1-y0));