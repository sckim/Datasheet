N=21
[w1, w2] = freqspace(N,'meshgrid');
Hd = ones(N);


% 반경이 같은 region
%r = sqrt(f1.^2 + f2.^2);

% 좌표의 합의 절대값에 대한 region
%r = abs(w1 - w2);

% 각각의 절대값에 대한 region
r = abs(w1) +abs(w2);

%r = abs
%Hd((r<0.1) | (r>0.5)) = 0;
Hd((r>0.5)) = 0;
imshow(Hd)
h = fwind1(Hd,hamming(N));
freqz2(h)