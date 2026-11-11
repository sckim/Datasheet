function z=LimAve(x)
%
% LimAve.m  evalin.m function에 대한 예제 함수!
%
% 2007, 05, 12  By Lim Jong Su
%  
Number = evalin('base','ElementNums');
 
z=sum(x)/Number;
 
if z ~= SubLimAve(Number)
    error('LimMatlab:ArgsExs','Two values must be same!!');
end
 
function y=SubLimAve(Num)
 
Tempx=evalin('caller','x');
 
y=sum(Tempx)/Num;