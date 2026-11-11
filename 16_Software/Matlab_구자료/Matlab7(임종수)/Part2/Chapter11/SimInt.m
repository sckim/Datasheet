function SSim=SimInt(FuncPtr,Interval,DivNum)
%
% Numerical Integration : Simpson's rule.
%
% 매개변수 설명 :
% 1) FuncPtr : 적분하려는 Function Handle.
% 2) Interval : 적분하기 위한 구간. 2개의 원소를 갖는 수치 벡터.
% 3) DivNum : 적분 구간의 개수.
%
% 2001, 12, 30              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

if DivNum < 2
    error('DivNum는 2이상이어야 한다.');
end

b=Interval(2);
a=Interval(1);
n=DivNum/2;     
h=(b-a)/DivNum;
IntervalVect=a:h:b;
% S0=f(0)+f(2n) :
S0=abs(feval(FuncPtr,a))+abs(feval(FuncPtr,b));
% S1=f(1) + f(3) + ... + f(2n-1) :
EvenInd=2:2:(2*n);
S1=sum(abs(feval(FuncPtr,IntervalVect(EvenInd))));
% S2=f(2) + f(4) + ... + f(2n-2) :
if n==1			% DivNum=2인 경우!
    S2=0
else
    OddInd=3:2:(2*n-1);
    S2=sum(abs(feval(FuncPtr,IntervalVect(OddInd))));
end;

SSim = (h/3)*(S0+4*S1+2*S2);
