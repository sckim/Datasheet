function Sig=FHndDemo2(x)
%
% Function Handle Demo 2
%
% 2002, 1, 19               By Lim Jong Su

% FHndDemo2.m함수에서 전역 변수로 선언한 function handle인 aveHnd.

global aveHnd			
aveHnd=@average;

n=length(x);
Dev=x-feval(aveHnd,x);					% ▶ ④
Sig=sqrt(sum(Dev.^2)/n);