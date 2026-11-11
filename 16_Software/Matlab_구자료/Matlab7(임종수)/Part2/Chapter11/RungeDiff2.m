function RungeResult2=RungeDiff2(FuncPtr, Init_cond, h, n)
%
% Differentiation Equation Solution : Second Order.
%-> Runge-Kutta-Nystrom의 방법.
% 매개변수 설명 :
% 1) FuncPtr : 2계 미분방정식.
% 2) Init_cond : 초기 조건. [Init_x, Init_y, Init_y']
% 3) h : 증분.
% 4) n : 반복 계산 횟수.
% 5) RungeResult2 : 미분 방정식 x, y의 해.
%
% 2002, 01, 04              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

xn=Init_cond(1);
yn=Init_cond(2);
Diff1yn=Init_cond(3);
k=(1/2)*h;

yn=[yn ; zeros(n-1,1)];
xn=[xn ; zeros(n-1,1)];
for index=1:(n-1)
    An=k*feval(FuncPtr,xn(index),yn(index),Diff1yn);
    DiffBeta=0.1*(Diff1yn+(1/2)*An);
    Bn=k*feval(FuncPtr,xn(index)+k,yn(index)+DiffBeta,Diff1yn+An);
    Cn=k*feval(FuncPtr,xn(index)+k,yn(index)+DiffBeta,Diff1yn+Bn);
    DiffDelta=0.2*(Diff1yn+Cn);
    Dn=k*feval(FuncPtr,xn(index)+h,yn(index)+DiffDelta,Diff1yn+2*Cn);

    yn(index+1)=yn(index)+h*(Diff1yn+(1/3)*(An+Bn+Cn));
    Diff1yn=Diff1yn+(1/3)*(An+2*Bn+2*Cn+Dn);
    xn(index+1)=h+xn(index);
end

RungeResult2=[xn yn];
