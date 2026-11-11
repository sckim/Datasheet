function [t, x, N]=ctift(f,X,df,dtm)

n=size(X,2);                  %신호의 개수
N=ceil(1/(dtm*df)); if N<n; N=n; end;   %IFFT 수행 위한 신호 개수
dt=1/(N*df);   %주파수 해상도
nnf=sum(f<0);  
Xa=zeros(1,N); 
Xa(1:n-nnf)=X(nnf+1:n); Xa(N-nnf+1:N)=X(1:nnf);
   %IFFT를 수행하기 위한 입력신호의 재정렬 및 영점 첨가(필요시)
xf=N*df*ifft(Xa);     %IFFT 수행
nc=ceil(N/2);
if nc==N/2
   x(1:nc-1)=xf(nc+2:N); x(nc:N)=xf(1:nc+1);
   t=(-nc+1)*dt:dt:nc*dt;
else
   x(1:nc-1)=xf(nc+1:N); x(nc:N)=xf(1:nc);
   t=(-nc+1)*dt:dt:(nc-1)*dt;
end
    %IFFT결과의 재정렬 및 시간축 scale 설정