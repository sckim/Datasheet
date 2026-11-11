
% Bias stability
%
rb1=50e3; rb2=10e3; re=1.2e3; rc=6.8e3;
vcc=10; vbe=0.7; icbo25=1e-6; beta=(150+200)/2;
vbb=vcc*rb2/(rb1+rb2);
rb=rb1*rb2/(rb1+rb2);
ic=beta*(vbb-vbe)/(rb+(beta+1)*re);

%stability factors are calculated
svbe=-beta/(rb+(beta+1)*re);
alpha=beta/(beta+1);
svcc=1/(rc + (re/alpha));
svicbo=(rb+re)/(re+(rb+re)/alpha);
sbeta=((rb+re)*(vbb-vbe+icbo25*(rb+re))/(rb+re+beta*re)^2);
% Calculate changes in Ic for various temperatures

t=25:1:100;
len_t = length(t);
dbeta = 50; dvcc=0.1;
for i=1:len_t
dvbe(i)= -2e-3*(t(i)-25);
dicbo(i)=icbo25*(2^((t(i)-25)/10)-1);
	dic(i)=svbe*dvbe(i)+svcc*dvcc...
		+svicbo+dicbo(i)+sbeta*dbeta;
end
plot(t,dicbo)
title('Change in collector current vs. temperature')
xlabel('Temperature, degree C')
ylabel('Change in collector current, A') 