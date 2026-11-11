%
%[예제 4-6]의 내용을 정리 한 M-file.
%
%1998.2.5        By Lim Jong_Su
%

clear all
close all

t=(0:.001:1)';    		%시간 벡터 t.
f1=50;              	%주파수 벡터 f1, f2
f2=120;
y=eval('sin(2*pi*f1*t)+2*sin(2*pi*f2*t)');
yn=y+0.5*randn(size(t));
plot(t(1:50),yn(1:50))
xlabel('time[msec]');
ylabel('진폭');
title(['주파수가 ' num2str(f1) ' , ' num2str(f2) ' 인 경우!']);