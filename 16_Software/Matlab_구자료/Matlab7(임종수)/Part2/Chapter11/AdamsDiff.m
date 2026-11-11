function AdamsResult=AdamsDiff(FuncPtr, Init_cond, h, n)
%
% Differentiation Equation Solution : Adams-Moulton's Method.
%
% 매개변수 설명 :
% 1) FuncPtr : 미분방정식.
% 2) Init_cond : 초기 조건. [Init_x, Init_y]
% 3) h : 증분.
% 4) n : 반복 계산 횟수.
% 5) AdamsResult : 미분 방정식의 x, y의 해.
% 2002, 01, 02              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.
%y1, y2, y3의 결과를 우선, Runge -Kutta의 방법으로 얻는다.

RungeResult=RungeDiff(FuncPtr,Init_cond,h,n);
yn=Init_cond(2);

yn=[RungeResult(1:4,2) ; zeros(n-4,1)];
xn=[Init_cond(1):h:(n-1)*h]';   % xn을 역벡터 형태로 만들기 위해서 transpose하였다.
for index=1:(n-4)
    % Predict Term!
    Predict=yn(index+3)+(h/24)*(55*feval(FuncPtr,xn(index+3),yn(index+3)) ...
        -59*feval(FuncPtr,xn(index+2),yn(index+2))+ ...
        37*feval(FuncPtr,xn(index+1),yn(index+1))- ...
        9*feval(FuncPtr,xn(index),yn(index)));
    % Correct Term!
    Correct=yn(index+3)+(h/24)*(9*feval(FuncPtr,xn(index+4),Predict) ...
        +19*feval(FuncPtr,xn(index+3),yn(index+3))-...
        5*feval(FuncPtr,xn(index+2),yn(index+2))+...
        feval(FuncPtr,xn(index+1),yn(index+1)));

    yn(index+4)=Correct;
end

AdamsResult=[xn yn];
