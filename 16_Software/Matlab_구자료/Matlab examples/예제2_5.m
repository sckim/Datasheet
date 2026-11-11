k=-5:5;
xk = stepfun(t,0)-2.*stepfun(t,1)+stepfun(t,2);
hk = stepfun(t,0)-stepfun(t,1);
yk = conv(xk,hk);
plot(yk);
