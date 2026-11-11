%
%FREQ     함수 csort.m에의해 반환된 행 벡터에대해 목록을 list한다. 
% !주의 : csort.m함수를 필요로 한다.
% 1993.8.4     By  Paul E. Pfeiffer
% 1998.2.7     modified by Lim Jong_Su
%

T = input('List 될 행 벡터를 입력 하시요! :');
n = length(T);
H = csort(T)';
A = [H H(:,2)/n];
disp(' ')			%한 줄 띄우기!
disp(['List안에 있는 원소의 수 :  ',num2str(n)] )
disp(' ')
disp('각각의 수치  발생 횟수 발생 비율')
disp(A)