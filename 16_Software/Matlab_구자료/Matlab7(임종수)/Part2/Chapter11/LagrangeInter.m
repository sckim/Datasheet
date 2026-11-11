function Result=LagrangeInter(x,varargin)
%
% Lagrange's Interpolation formula.
%
% 2001, 12, 30              By Lim Jong Su
%
% Reference : 
% Erwin Kreyszig's Advanced Engineering Mathematics.

DoubleVal=[varargin{:}];  % varargin의 cell array를 double type의 array로 변환!

XVal=DoubleVal(1:2:(end-1))';    % 입력값들에서 x좌표 값.
YVal=DoubleVal(2:2:end)';         % 입력값들에서 y좌표 값.     
       
if sort(XVal) ~=  (XVal)
    error('x0, x1, x2, ...의 순으로 값이 커져야 한다.');
end

Temp=0;
ExtendXVal=ones(length(XVal)-1,1)*x;
NewIndex=1:length(XVal);
for index=1:length(XVal)
    NewIndex(index)=[];			% 빈 행렬을 사용하고 있는데 주의!
    NumVal=prod(ExtendXVal-XVal(NewIndex))  % (식 12-16)에서 분자를 계산!
    ExtendXVal2=ones(length(XVal)-1,1)*XVal(index);
    DeNVal=prod(ExtendXVal2-XVal(NewIndex))  % (식 12-16)에서 분모를 계산!

    Temp=Temp+(NumVal/DeNVal)*YVal(index);
    NewIndex=1:length(XVal);
end

Result=Temp;