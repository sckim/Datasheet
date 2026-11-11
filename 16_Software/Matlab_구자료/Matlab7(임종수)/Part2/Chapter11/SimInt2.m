function SSim=SimInt2(FuncPtr,XInterval,XDivNum,YInterval,YDivNum)
%
% Numerical Double Integration : Simpson's rule.
%
% 매개변수 설명 :
% 1) FuncPtr : 변수 x, y로 이루어진 적분하려는 함수의 Function Handle.
% 2) XInterval : 적분하기 위한 변수 x의 구간. 2개의 원소를 갖는 수치 벡터.
% 3) XDivNum : 변수 y의 적분 구간의 개수.
% 4) YInterval : 적분하기 위한 변수 y의 구간. 
%     --> 2개의 원소를 갖는 Function Handle 벡터.
% 5) XDivNum : 변수 x의 적분 구간의 개수.
%
% 2001, 12, 30              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.
% SSim=SimInt(FuncPtr,Interval,DivNum)

if (XDivNum < 2) & (YDivNum < 2)
    error('XDivNum, YDivNum는 2이상이어야 한다.');
end

Simpson1=@SimInt;

Xb=XInterval(2);
Xa=XInterval(1);
Xn=XDivNum/2;     
Xh=(Xb-Xa)/XDivNum;
XIntervalVect=Xa:Xh:Xb;

Yb=YInterval(2);
Ya=YInterval(1);
if (~isa(Yb,'function_handle')) & (~isa(Ya,'function_handle'))
    error('y의 범위는 Function handle로 이루어져야 한다.')
end    

% S0=f(0) :
yLow{1}=Ya; yLow{2}=Xa;
yHigh{1}=Yb; yHigh{2}=Xa;
yRange=[yLow yHigh];
S0=feval(Simpson1,FuncPtr,yRange,YDivNum,Xa);

% S1=f(1) + f(3) + ... + f(2n-1) :
EvenInd=2:2:(2*Xn);
ELen=length(EvenInd);
S1=0;
for IndexX=1:ELen
    yLow{1}=Ya; yLow{2}=XIntervalVect(EvenInd(IndexX));
    yHigh{1}=Yb; yHigh{2}=XIntervalVect(EvenInd(IndexX));
    yRange=[yLow yHigh];
S1=S1+feval(Simpson1,FuncPtr,yRange,YDivNum,XIntervalVect(EvenInd(IndexX)));
end

% S2=f(2) + f(4) + ... + f(2n-2) :
if Xn==1
    % S0=f(2n) :
    yLow{1}=Ya; yLow{2}=Xb;
    yHigh{1}=Yb; yHigh{2}=Xb;
    yRange=[yLow yHigh];
    S2=(1/2)*feval(Simpson1,FuncPtr,yRange,YDivNum,Xb);
else
    OddInd=3:2:(2*Xn-1);
    OLen=length(OddInd);
    S2=0;
    for IndexX=1:OLen

       yLow{1}=Ya; yLow{2}=XIntervalVect(OddInd(IndexX));
        yHigh{1}=Yb; yHigh{2}=XIntervalVect(OddInd(IndexX));
        yRange=[yLow yHigh];

S2=S2+feval(Simpson1,FuncPtr,yRange,YDivNum,XIntervalVect(OddInd(IndexX)));
    end
end;

SSim = (Xh/3)*(S0+4*S1+2*S2);

function SSim=SimInt(FuncPtr,Interval,DivNum,x)
%
% Numerical Integration : Simpson's rule version 2.
%
% 매개변수 설명 :
% 1) FuncPtr : 적분하려는 Function Handle.
% 2) Interval : 적분하기 위한 구간. 2개의 원소를 갖는 수치 벡터.
% 3) DivNum : 적분 구간의 개수.
% 4) x : 변수 x의 고정된 값.
%
% 2001, 12, 30              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

if DivNum < 2
    error('DivNum는 2이상이어야 한다.');
end

Tempb=Interval(3:4);
b=feval(Tempb{1},Tempb{2});
Tempa=Interval(1:2);
a=feval(Tempa{1},Tempa{2});
n=DivNum/2;   
h=(b-a)/DivNum;
IntervalVect=a:h:b;
% S0=f(0)+f(2n) :
S0=feval(FuncPtr,a,x)+feval(FuncPtr,b,x);

if ~isempty(IntervalVect)
    % S1=f(1) + f(3) + ... + f(2n-1) :
    EvenInd=2:2:(2*n);
    S1=sum(feval(FuncPtr,IntervalVect(EvenInd),x));
    % S2=f(2) + f(4) + ... + f(2n-2) :
    if n==1
        S2=0;
    else
        OddInd=3:2:(2*n-1);
        S2=sum(feval(FuncPtr,IntervalVect(OddInd),x));
    end;
else
    S1=0; S2=0;
end
SSim = (h/3)*(S0+4*S1+2*S2);