w=-10:0.01:10;

y = sin(w);
for i=3:2:200
   y = y + (1/i).*sin(i.*w);
end
plot(w,y);