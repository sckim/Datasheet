%
% Inverter closed loop gain versus frequency
%
w = logspace(-2,10);
f = w/(2*pi);
r12 = [100 600 1100];
a =[];
b = [];
num = [];
den = [];
h = [];
for i = 1:3
 a(i) = 2*pi*1.0e8*r12(i)/(1+r12(i));
 b(i) = 2*pi*1.0e8*((1/(1+r12(i))) + 1.0e-7);
 num = [a(i)];
 den = [1 b(i)];
 h(i,:) = freqs(num,den,w);
end

semilogx(f,abs(h(1,:)),'w',f,abs(h(2,:)),'w',f,abs(h(3,:)),'w')
title('Op Amp Frequency Characteristics')
xlabel('Frequency, Hz')
ylabel('Gain')
axis([1.0e-2,1.0e10,0,1200])
text(1.5e-2, 150, 'Resistance ratio of 100')
text(1.5e-2, 650, 'Resistance ratio of 600')
text(1.50e-2, 1050, 'Resistance ratio of 1100')