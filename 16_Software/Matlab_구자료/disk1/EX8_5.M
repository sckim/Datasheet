% DFT of g(t)
%  Sample 1, Sampling interval of 0.05 s
ts1 = 0.05;   % sampling interval
fs1 = 1/ts1;  %  Sampling frequency
n1 = 1000;     %  Total Samples
m1 = 1:n1;    %  Number of bins
sint1 = ts1*(m1 - 1);  %  Sampling instants
freq1 = (m1 - 1)*fs1/n1;  % frequencies 
gb = (4*exp(-2*sint1)).*cos(2*pi*10*sint1);
gb_abs = abs(fft(gb));
subplot(121)
plot(freq1, gb_abs)
title('DFT of g(t), 0.05s Sampling interval')
xlabel('Frequency (Hz)')

%  Sample 2,  Sampling interval of 0.2 s
ts2 = 0.2;   % sampling interval
fs2 = 1/ts2;  %  Sampling frequency
n2 = 250;     %  Total Samples
m2 = 1:n2;    %  Number of bins
sint2 = ts2*(m2 - 1);  %  Sampling instants
freq2 = (m2 - 1)*fs2/n2;  % frequencies 
gc = (4*exp(-2*sint2)).*cos(2*pi*10*sint2);
gc_abs = abs(fft(gc));
subplot(122)
plot(freq2, gc_abs)
title('DFT of g(t), 0.2s Sampling interval')
xlabel('Frequency (Hz)')
