function MEulerResult=ModEulerDiff1(FuncPtr, Init_cond, h, n)
%
% Differentiation Equation Solution : Modified Euler Method.
%
% 매개변수 설명 :
% 1) FuncPtr : 미분방정식.
% 2) Init_cond : 초기 조건. [Init_x, Init_y]
% 3) h : 증분.
% 4) n : 반복 계산 횟수.
% 5) MEulerResult : 미분 방정식의 x, y의 해.
% 2002, 01, 02              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

xn=Init_cond(1);
yn=Init_cond(2);

yn=[yn ; zeros(n-1,1)];
xn=[xn ; zeros(n-1,1)];
for index=1:(n-1)
    kn=h*feval(FuncPtr,xn(index),yn(index));
    ln=h*feval(FuncPtr,xn(index)+h,yn(index)+kn);
    yn(index+1)=yn(index)+(1/2)*(kn+ln);
    xn(index+1)=h+xn(index);
end

MEulerResult=[xn yn];
