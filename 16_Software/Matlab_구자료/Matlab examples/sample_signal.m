function sample_signal(f0, fs, ti, tf, t, xt, pl)

  k=ti:1/fs:tf;               %샘플 개수 설정
  xk=cos(2*pi*f0*k);         %샘플링된 신호 계산
  figure
  subplot(2,1,pl);
  plot(t,xt,'k:'), axis([ti tf -1.5 1.5])  %x(t)그림
  hold on
  stem(k,xk,'k')           %x[k]파형 출력
  hold off
  title('\bf{샘플링된 신호 x[k]}'); 
  xlabel('\bf{t}','fontsize',12); grid on;
  h=legend('x(t)', 'x[k]', 0);     %x(t)와 x[k] 파형 구별
