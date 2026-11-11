%Input characteristics of a BJT
%
diary ex12_1.dat
diary on
k=1.381e-23; temp=300; q=1.602e-19;
cur_den=2e-10; area=5.0; beta_f=120; beta_r=0.3;
vt=k*temp/q; is=cur_den*area;
alpha_f=beta_f/(1+beta_f); 
alpha_r = beta_r/(1+beta_r);
ies=is/alpha_f;
vbe=0.3:0.01:0.65; 
ics=is/alpha_r;
m=length(vbe)

for i = 1:m
 ifr(i) = ies*exp((vbe(i)/vt)-1);
 ir1(i) = ics*exp((-1.0/vt)-1);
 ie1(i) = abs(-ifr(i) + alpha_r*ir1(i));
end

plot(vbe,ie1)
title('Input characteristics')
xlabel('Base-emitter voltage, V')
ylabel('Emitter current, A')

