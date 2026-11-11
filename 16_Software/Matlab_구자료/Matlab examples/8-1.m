clear;
f0=100; fs=300;    %신호의 고유 및 샘플링 주파수 설정
N0=10;             %데이터 개수 설정
dfm=fs/N0/2;         %최대 주파수 해상도 설정
Ts=1/fs; ti=(-N0+1)*Ts; tf=N0*Ts; 
k=ti:Ts:tf;               %샘플 개수 설정
x=cos(2*pi*f0*k);         %샘플링된 신호 계산
[f, X, N, nc]=dtft(k,x,Ts,dfm)   %이산시간 Fourier변환 수행
Xamp=abs(X)/max(abs(X));     %(규준화된) 진폭 스펙트럼 계산
figure
subplot(2,1,1); plot(f,Xamp), axis([f(1) f(length(f)) 0 1.2]); 
title('\bf{샘플링된 신호의 진폭 스펙트럼}'); xlabel('\bf{f}');
