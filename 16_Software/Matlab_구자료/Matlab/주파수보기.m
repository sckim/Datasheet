Record_Time = 2;
Signal_Freq = 1;
Sampling_Freq = 100;
Nyquist_Freq = Sampling_Freq/2;
Data_Size=Record_Time*Sampling_Freq;
Xaxis_scale = (0:Data_Size/2-1)/(Data_Size/2)*Nyquist_Freq;

t=0:1/Sampling_Freq:Record_Time-(1/Sampling_Freq);
x=sin(2*pi*2*t)+2*cos(2*pi*5*t)+10*sin(2*pi*30*t);
%x=sin(2*pi*Signal_Freq*t);

subplot(3,1,1)
plot(x), title('Time domain signal');
xlabel('sec'), ylabel('x(t)');

subplot(3,1,2)
Y=fft(x); title('Frequency domain signal');
plot(Xaxis_scale,  abs(Y(1:Data_Size/2)));
xlabel('Hz'), ylabel('|X(f)|^2');

subplot(3,1,3)
Y=fft(x); title('Phase domain signal');
plot(Xaxis_scale,  angle(Y(1:Data_Size/2)));