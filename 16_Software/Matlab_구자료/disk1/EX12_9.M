%
% common-sourceamplifier
%
diary ex12_9.dat
diary on
rg1=5e6; rg2=5e6; rd=8e3; rl=10e3;
ri=50; rs=2e3; rds=50e3;
cc1=1e-6; cc2=1e-6; cs=50e-6;
gm=10e-3; cgs=10e-12; cgd=1e-12; cds=1e-12;

% Calculate midband gain using equation (12.108)
a = (1/rds) + (1/rd) + (1/rl);
rlprime = 1/a;
rg = rg1*rg2/(rg1 + rg2);
gain_mb = -gm*rg*rlprime/(ri + rg);

% Calculate Low cut-off frequency using equation (12.113)
t1 = cc1*(rg + ri);
wl1 = 1/t1;
rd_rds = (rd*rds)/(rd + rds);
t2 = cc2 * (rl + rd_rds);
wl2=1/t2;
t3=cs * rs/(1 + gm * rs);
wl3=1/t3;
wl=sqrt(wl1^2 + wl2^2 + wl3^2);

% Calculate high frequency cut-off using equations (12.115 to 12.119)
c1=cgs + cgd * (1 + gm * rlprime);
c2=cds + cgd;
rg_ri=rg * ri/(rg + ri);
wh1=1/(rg_ri * c1);
wh2=1/(rlprime * c2);
int_term = sqrt((1/wh1)^2 + (1/wh2)^2);
wh = 1/int_term;
bw = wh-wl;

%  Print results
fprintf('Midband Gain is %8.3f\n', gain_mb)
fprintf('Low frequency cut-off is %8.3e\n', wl)
fprintf('High frequency cut-off is %8.3e\n', wh)
fprintf('Bandwidth is %8.3e Hz\n', bw)
