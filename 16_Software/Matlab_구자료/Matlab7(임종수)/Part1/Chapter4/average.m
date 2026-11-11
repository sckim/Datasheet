function ave=average(x)
%
% 평균을 구해주는 함수.
% 
% 2002, 1, 19               By Lim Jong Su

% FHndDemo1.m함수에 있는 sub function과
% 매개변수가 다른데 주의하자!
n=length(x);
ave=sum(x)/n;