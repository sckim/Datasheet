%output characteristic of an npn transistor
%
diary ex12_2.dat
k=1.381e-23; temp=300; q=1.602e-19;
cur_den=2.0e-15; area=5.5; alpha_f=0.98; 
alpha_r=0.35; vt=k*temp/q; is=cur_den*area;
ies=is/alpha_f; ics=is/alpha_r;
vbe= [0.65];
vce=[0 0.07 0.1 0.2 0.3 0.4 0.5 0.6 0.7 1 2 4 6];
n=length(vbe);
m=length(vce);
for i=1:n
  for j=1:m
    ifr(i,j)= ies*exp((vbe(i)/vt) - 1);
    vbc(j) = vbe(i) - vce(j);
    ir(i,j) = ics*exp((vbc(j)/vt) - 1);
    ic(i,j) = alpha_f*ifr(i,j) - ir(i,j);
  end
end
ic1 = ic(1,:);
plot(vce, ic1,'w')
title('Output Characteristic')
xlabel('Collector-emitter Voltage, V')
ylabel('Collector current, A')
text(3,3.1e-4, 'Vbe = 0.65 V')
axis([0,6,0,4e-4])