clear all;
f=-1:1/(2*pi^2):1 ; w=2*pi*f;        %주파수 간격 설정
z=exp(j*w);
X=z./(z-(4/5));
Y=(z.^(-1))./(z-(4/5));
V=(z.^(3))./(z-(4/5));
W=(z.^3)./(z-(4/5))-z.^2-(4/5)*z;
Xamp=abs(X); Xph=angle(X)*180/pi;    %x[k]의 주파수 스펙트럼 계산
Yamp=abs(Y); Yph=angle(Y)*180/pi;    %y[k]의 주파수 스펙트럼 계산
Vamp=abs(V); Vph=angle(V)*180/pi;    %v[k]의 주파수 스펙트럼 계산
Wamp=abs(W); Wph=angle(W)*180/pi;    %w[k]의 주파수 스펙트럼 계산
figure 
subplot(2,2,1),plot(f,Xamp);          %x[k]의 진폭 스펙트럼 도시 
title('진폭 스펙트럼'); xlabel('f');
subplot(2,2,3),plot(f,Xph);           %x[k]의 위상 스펙트럼 도시 
title('위상 스펙트럼'); xlabel('f');
subplot(2,2,2),plot(f,Yamp);          %y[k]의 진폭 스펙트럼 도시 
title('진폭 스펙트럼'); xlabel('f');
subplot(2,2,4),plot(f,Yph);           %y[k]의 위상 스펙트럼 도시 
title('위상 스펙트럼'); xlabel('f');
figure 
subplot(2,2,1),plot(f,Vamp);          %v[k]의 진폭 스펙트럼 도시 
title('진폭 스펙트럼'); xlabel('f');
subplot(2,2,3),plot(f,Vph);           %v[k]의 위상 스펙트럼 도시 
title('위상 스펙트럼'); xlabel('f');
subplot(2,2,2),plot(f,Wamp);          %w[k]의 진폭 스펙트럼 도시 
title('진폭 스펙트럼'); xlabel('f');
subplot(2,2,4),plot(f,Wph);           %w[k]의 위상 스펙트럼 도시 
title('위상 스펙트럼'); xlabel('f');
