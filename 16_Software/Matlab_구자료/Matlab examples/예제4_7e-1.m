R=1; C=1;         					%R과 C의 값을 설정
w0=pi;
N=40;
for n=1:N
   h(n)=1/(R*C)*1/(j*n*w0 + 1/R/C); 
end
h_am = abs(h);               		%|H(w)|를 구함
h_ang= angle(h);            		%∠H(w)를 구함
figure
subplot(2,1,1);stem(h_am);
title('\bf{진폭 응답}');xlabel('\bf{log w}');
subplot(2,1,2);stem(h_ang);
title('\bf{위상 응답}');xlabel('\bf{log w}');
