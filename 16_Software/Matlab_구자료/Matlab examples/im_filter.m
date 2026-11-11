cut_off=180;
imread('lena.jpg','jpg');
temp=fftshift(fft2(lena));
imshow(abs(temp));
Temp1=zeros(512,512);
Temp1(cut_off:512-cut_off,cut_off:512-cut_off)=temp(cut_off:512-cut_off,cut_off:512-cut_off);
Temp1=ifftshift(Temp1);
temp1 = ifft2(Temp1);
imshow(abs(temp1)*0.005);

