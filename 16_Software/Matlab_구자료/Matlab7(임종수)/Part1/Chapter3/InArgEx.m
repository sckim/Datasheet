function InArgEx(Var, No)
%
%InArgEx.m  inputname.m에 대한 예제 함수!
%
%2007, 05, 13  By Lim Jong Su
%

if strcmp(inputname(1), 'Exp')
    warning('InputArgEx:InArgEx', ...
        'The First input argument name must be Exp');
end

disp(['The second input argument name :' inputname(2)])