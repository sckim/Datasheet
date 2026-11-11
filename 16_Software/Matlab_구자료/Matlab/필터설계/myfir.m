w1=0:0.05:5;
B1=[1];
A1=[1 2 2 1];
[H1s]=freqs(B1,A1,w1);
plot(w1, abs(H1s)), title('Filter H1(s)')
