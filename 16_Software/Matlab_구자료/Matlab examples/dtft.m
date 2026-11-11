function [f, X, N, nc]=dtft(k,x,Ts,dfm)

n=size(x,2);                  %신호의 개수
N=ceil(1/(dfm*Ts)); if N<2*n; N=2*n; end;   %FFT 수행 위한 신호 개수
df=1/(N*Ts);   %주파수 해상도
nnk=sum(k<0);  
xa=zeros(1,N); xa(1:n-nnk)=x(nnk+1:n); xa(N-nnk+1:N)=x(1:nnk);
   %FFT를 수행하기 위한 입력신호의 재정렬 및 영점 첨가(필요시)
Xf=fft(xa);     %FFT 수행
nc=ceil(N/2);
if nc==N/2
   X(1:nc-1)=Xf(nc+2:N); X(nc:N)=Xf(1:nc+1);
   f=(-nc+1)*df:df:nc*df;
else
   X(1:nc-1)=Xf(nc+1:N); X(nc:N)=Xf(1:nc);
   f=(-nc+1)*df:df:(nc-1)*df;
end
    %FFT결과의 재정렬 및 주파수축 scale 설정
