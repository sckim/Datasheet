function z=ErrorEx1(x)
%
% FuncHndEx1.m  Function Handle에 대한 예제 함수!
%
% 2007, 05, 12  By Lim Jong Su
%
if isscalar(x)
  error('ErrorEx:InArgsRuleOut','Input must be vector \n By Lim Jong Su');
end

z= sum(x)/numel(x);