%
% Chapter 9. 연습문제 1에 대한 M-file.
%
% 2002, 6, 13            By Lim Jong Su
%

x=linspace(-2*pi,2*pi,32);
y=sin(x);

IndMax=32/8;

for Ind=1:IndMax
    disp([num2str(x((8*Ind-7):8*Ind)) char(13)]);
end;

disp([char(13) char(13)])

for Ind=1:IndMax
    disp([num2str(y((8*Ind-7):8*Ind)) char(13)]);
end;    