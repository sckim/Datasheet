function yRange=yMin(x)
%
% Numerical Double Integration : Simpson's Rule.
% --> 변수 y의 최소값.
%
% 2001, 12, 30              By Lim Jong Su
%

%yRange=log(x);               % [예제 8]의 경우.
                           
%yRange=0;                   % [예제 9]의 경우.
%a=x;        % [예제 9]의 경우 입력 변수 x를 사용하지 않는다. 
                % 이때, warnning이 발생하지 않도록 a=x로 하였다.
                
yRange=0;                       % (식 27)의 경우.
a=x;