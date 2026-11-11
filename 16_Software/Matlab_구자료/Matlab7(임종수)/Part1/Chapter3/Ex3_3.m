%
% 이 프로그램은 [예제 3-3]에 대한 내용들이다.
%
% By MathWorks.com
%

close all
clear all

X=[];
X0=[1 1 1]';

A=[0 -6 -1;6 2 -16;-5 20 -10];

for t=0:.01:1
   X=[X expm(t*A)*X0];
end

plot3(X(1,:),X(2,:),X(3,:),'-o')
grid on
