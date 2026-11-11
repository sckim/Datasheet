function SRec=RectInt(FuncPtr,Interval,DivNum)
%
% Numerical Integration : Rectangular rule.
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

b=Interval(2);
a=Interval(1);
h=(b-a)/DivNum;
IntervalVect=a:h:b;
Temp=(1/2)*(IntervalVect+[IntervalVect(2:end),0]);
RectMidPointVect=Temp(1:(end-1));

SRec=h*sum(abs(feval(FuncPtr,RectMidPointVect)));			     
