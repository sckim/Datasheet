t=0:1/100:2*pi-1/100;
s=sin(t);

s_n = zeros(1000,length(s));
for i=1:1000
    n=randn(1,length(s));
    s1=s+n;
    s_n(i,:)=s1;
end

for i=1:999
    plot(t, mean(s_n(1:i+1,:)));
    pause(1);
end

