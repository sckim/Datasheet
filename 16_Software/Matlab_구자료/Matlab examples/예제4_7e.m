w=0.1:0.01:10;          %값을 볼 주파수 범위를 정함 
R=1; C=1;         					%R과 C의 값을 설정
h=1/(R*C)*1./(j*w + 1/R/C);    		%H(w)를 나타냄
h_am = abs(h);               		%|H(w)|를 구함
h_ang= angle(h);            		%∠H(w)를 구함
figure
subplot(2,1,1);plot(log10(w),h_am);
title('\bf{진폭 응답}');xlabel('\bf{log w}');
subplot(2,1,2);plot(log10(w),h_ang);
title('\bf{위상 응답}');xlabel('\bf{log w}');
