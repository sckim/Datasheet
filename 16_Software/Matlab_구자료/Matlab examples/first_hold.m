function first_hold(f0, fs, ti, tf, t, xt)

  k=ti:1/fs:tf;                     %샘플 개수 설정
  xk=cos(2*pi*f0*k);               %샘플링된 신호 x[k] 계산
x1=zeros(1,length(xk)); x2=zeros(1,length(xk));
for m=1:2:length(xk)
	 x1(m)=xk(m);
end   
for m=2:2:length(xk)
   x2(m)=xk(m);
end
     % 각 샘플에서의 일차 홀드 파형 표시를 위한 데이터 계산

  figure
  subplot(2,1,1);
  plot(t,xt,'k'), axis([ti tf -1.5 1.5])    %x(t)파형 출력
  hold on
plot(k,x1,'k:')          %각 샘플에서의 일차 홀드 파형 표시
plot(k,x2,'k:')          %각 샘플에서의 일차 홀드 파형 표시
  stem(k,xk,'k')            %x[k]파형 출력
  hold off
  title('\bf{샘플링된 신호 x[k]}'); xlabel('\bf{t}'); 
  subplot(2,1,2);
  plot(t,xt,'k:'), axis([ti tf -1.5 1.5])   %x(t)파형 출력
  hold on
  plot(k,xk,'k')       %일차 홀드를 이용한 신호의 복원 파형 출력
  hold off
  title('\bf{일차 홀드에 의한 복원 신호}'); xlabel('\bf{t}');  

