function Diff2Result=EulerDiff2(FuncPtr, Init_cond, h, n)
%
% Differentiation Equation Solution : Second Order.
%
% 매개변수 설명 :
% 1) FuncPtr : 2계 미분방정식.
% 2) Init_cond : 초기 조건. [Init_x, Init_y, Init_y']
% 3) h : 증분.
% 4) n : 반복 계산 횟수.

% 5) Diff2Result : 미분 방정식의 x, y의 해.
% 2002, 01, 03              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

xn=Init_cond(1);
yn=Init_cond(2);
Diffyn=Init_cond(3);

yn=[yn ; zeros(n-1,1)];
xn=[xn ; zeros(n-1,1)];
for index=1:(n-1)
    Diff2yn=feval(FuncPtr,xn(index),yn(index),Diffyn);
    yn(index+1)=yn(index)+h*Diffyn+((h^2)/2)*Diff2yn;
    Diffyn=Diffyn+h*Diff2yn;
    xn(index+1)=h+xn(index);
end

Diff2Result=[xn yn];
