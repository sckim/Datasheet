function [Dev, Sig]=FHndDemo3(x)
%
% Function Handle Demo 1
% 
% 2002, 1, 19               By Lim Jong Su

aveHnd=@average;

n=length(x);
Dev=x-average(x,n);
Sig=FHndDemo2b(x,aveHnd);				%	¢º ¨í

% Function Handle Demo 1 :
% Sub Function
function ave=average(x,n)
ave=sum(x)/n;