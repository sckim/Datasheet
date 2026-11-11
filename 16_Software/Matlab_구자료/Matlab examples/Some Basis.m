
A=zeros(16);

i=0:15;

for j=1:16
   A(j,:)=exp(j*2*pi*((i*(j-1))/16+(i*(j-1))/16));
end


% Cosine TransformÀÇ °è¼ö
N=16;
C=ones(N,N);

C(1,:)=ones(1,N)*(sqrt(1/N));

n=0:N-1;
for k=2:N
   C(k,:) = sqrt(2/N).*cos( (pi*(2*n+1)*(k-1))/(2*N) );
end

for k=1:N
   subplot(N,1,k);
   plot(n, C(k,:));
end
