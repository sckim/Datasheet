function Result=PolyInter(x,varargin)
%
% Newton's divided difference Interpolation formula.
%
% 2001, 12, 28              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

DoubleVal=[varargin{:}];  % varargin의 cell array를 double type의 array로 변환!

XVal=DoubleVal(1:2:(end-1));    % 입력값들에서 x좌표 값.
YVal=DoubleVal(2:2:end);         % 입력값들에서 y좌표 값.            
if sort(XVal) ~=  (XVal)
    error('x0, x1, x2, ...의 순으로 값이 커져야 한다.');
end

TempX=1;        % (x-xi)값을 계산하기 위한 임시변수.
TempY=0;        % f[x0,x1, ..., xk]값을 계산하기 위한 임시변수.
TempVal=0;      % f(x)값을 계산하기 위한 임시변수.
TempYD=1;       % (x(j+1)-xj)값을 계산하기 위한 임시변수.
for index=1:length(XVal)
    TempX=TempX*(x-XVal(index));
TempY=((YVal(index+1)-YVal(index))/TempYD-TempY)/(XVal(index+1)-XVal(1));
    TempVal=TempVal+TempX*TempY;
    if index <=(length(XVal)-2)
        TempYD=XVal(index+2)-XVal(index+1);
    else
        break;
    end;
end;

Result=YVal(1) + TempVal;