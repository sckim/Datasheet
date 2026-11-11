function [a,b]=FuncHndEx1(FuncHnd, x)
%
% FuncHndEx1.m  Function Handle에 대한 예제 함수!
%
% 2007, 05, 12  By Lim Jong Su
%

FuncHndMinMax = @FuncMinMax;

plot(x, FuncHnd(2*pi*x))

FuncMean=@(x) sum(x)/numel(x);

a=FuncMean(x);
b=FuncHndMinMax(x);					  


function [y,z]=FuncMinMax(x)

if nargout == 1
    y=min(x);
else if nargout == 2
    z=max(x);
    else
        error('LimMatlab7:FuncHndPart','You must be Wrong!!');
    end
end