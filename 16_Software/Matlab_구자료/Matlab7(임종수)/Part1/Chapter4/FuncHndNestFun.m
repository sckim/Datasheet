function b=FuncHndNestFun
%
% PlotFuncHnd.m  Function Handle & nested function에 대한 예제 함수!
%
% 2007, 05, 12  By Lim Jong Su
%

b=@TempAve;

    function Temp=TempAve(x)
        Temp=mean(x);
    end
end