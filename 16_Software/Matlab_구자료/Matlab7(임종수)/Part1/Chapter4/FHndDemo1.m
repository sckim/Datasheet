function Dev=FHndDemo1(x)
%
% Function Handle Demo 1
% 
% 2002, 1, 19               By Lim Jong Su
%   								в║ ич
n=length(x);
Dev=x-average(x,n);

% Function Handle Demo 1 :
% Sub Function
function ave=average(x,n)
ave=sum(x)/n;