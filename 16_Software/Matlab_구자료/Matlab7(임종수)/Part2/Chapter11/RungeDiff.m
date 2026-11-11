function RungeResult=RungeDiff(FuncPtr, Init_cond, h, n)
%
% Differentiation Equation Solution : Runge-Kutta Method.
%
% 매개변수 설명 :
% 1) FuncPtr : 미분방정식.
% 2) Init_cond : 초기 조건. [Init_x, Init_y]
% 3) h : 증분.
% 4) n : 반복 계산 횟수.
% 5) RungeResult : 미분 방정식의 x, y의 해.
% 2002, 01, 02              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

xn=Init_cond(1);
yn=Init_cond(2);

yn=[yn ; zeros(n-1,1)];
xn=[xn ; zeros(n-1,1)];
for index=1:(n-1)
    An=h*feval(FuncPtr,xn(index),yn(index));
    Bn=h*feval(FuncPtr,xn(index)+(1/2)*h,yn(index)+(1/2)*An);
    Cn=h*feval(FuncPtr,xn(index)+(1/2)*h,yn(index)+(1/2)*Bn);
    Dn=h*feval(FuncPtr,xn(index)+h,yn(index)+Cn);

    yn(index+1)=yn(index)+(1/6)*(An+2*Bn+2*Cn+Dn);
    xn(index+1)=h+xn(index);
end

RungeResult=[xn yn];
