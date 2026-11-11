function Result=NDiff(Func,x,h)
%
% Numerical Differentiation : Centered Formula of Order O(h^4).
%
% 매개변수 설명 :
% 1) Func : 미분하려는 Function Handle.
% 2) x : 미분 할 곳의 x값.
% 3) h : 증분.
%
% 2001, 12, 31              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

f2h=feval(Func,x+2*h);
fh=feval(Func,x+h);
f_h=feval(Func,x-h);
f_2h=feval(Func,x-2*h);

Result=(-f2h+8*fh-8*f_h+f_2h)/(12*h);