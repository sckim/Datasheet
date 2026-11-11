function zero_hold(f0, fs, ti, tf, t, xt)

  k=ti:1/fs:tf;                     %샘플 개수 설정
  xk=cos(2*pi*f0*k);               %샘플링된 신호 x[k] 계산
  figure
  subplot(2,1,1);
  plot(t,xt,'k:'), axis([ti tf -1.5 1.5])    %x(t)파형 출력
  hold on
  stem(k,xk,'k')           %x[k]파형 출력
  hold off
  title('\bf{샘플링된 신호 x[k]}'); xlabel('\bf{t}'); 
  subplot(2,1,2);
  plot(t,xt,'k:'), axis([ti tf -1.5 1.5])   %x(t)파형 출력
  hold on
  stairs(k,xk,'k')       %영차 홀드를 이용한 신호의 복원 파형 출력
  hold off
  title('\bf{영차 홀드에 의한 복원 신호}'); xlabel('\bf{t}');  
