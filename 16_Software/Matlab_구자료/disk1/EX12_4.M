% Integrated circuit Biasing
%
vcc=10; rc=50e3; vbe=0.7;
beta =40:5:200;
ir1=(vcc-vbe)/rc;
ir2=(vcc-2*vbe)/rc;
m=length(beta);

for i=1:m
   io1(i) = beta(i)*ir1/(beta(i) + 2);
   pd1(i)=abs((io1(i)-ir1)*100/ir1);
   io2(i)=(beta(i)^2+2*beta(i))/(beta(i)^2+2*beta(i)+2);
   pd2(i)=abs((io2(i)*ir2-ir2)*100/ir2);
end
subplot(211), plot(beta,pd1)
%title('error for simple current mirror')
xlabel('Transistor beta')
ylabel('Percentage error')
text(90,5,'Error for simple current mirror')
subplot(212),plot(beta,pd2)
%title('Error for Wilson current mirror')
xlabel('Transistor beta')
ylabel('Percentage error')
text(90, 0.13, 'Error for Wilson current source')
