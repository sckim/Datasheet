%
% 영상에서 선이 FFT되면 어떻게 되는가를 관찰해 보기 위한
% script이다.
%
% 이유에 대해서는 아직 명확하지 않다.
%
% Program by S.C. Kim.
% 1998. 6. 12
%
N=64;
x=eye(N);
X=fft2(x);

clf;
subplot(4,4,1);
imshow(x); title('Original line');

subplot(4,4,2)
imshow(fftshift(abs(X))); title('Image by FFT transform');

x=rot90(x);
X=fft2(x);
subplot(4,4,3);
imshow(x); title('Original line');

subplot(4,4,4)
imshow(fftshift(abs(X))); title('Image by FFT transform');

x=zeros(N);
x(N/2,:) = ones(1,N);
X=fft2(x);

subplot(4,4,5);
imshow(x); title('Original line');

subplot(4,4,6)
imshow(fftshift(abs(X))); title('Image by FFT transform');

x=rot90(x);
X=fft2(x);

subplot(4,4,7);
imshow(x); title('Original line');

subplot(4,4,8)
imshow(fftshift(abs(X))); title('Image by FFT transform');

x=zeros(N);
x(N/2,1:N/2) = ones(1,1:N/2);
X=fft2(x);

subplot(4,4,9);
imshow(x); title('Original line');

subplot(4,4,10)
imshow(fftshift(abs(X))); title('Image by FFT transform');

x=rot90(x);
X=fft2(x);

subplot(4,4,11);
imshow(x); title('Original line');

subplot(4,4,12)
imshow(fftshift(abs(X))); title('Image by FFT transform');