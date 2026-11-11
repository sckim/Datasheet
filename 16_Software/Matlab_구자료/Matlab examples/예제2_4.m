k=-0:0.01:9;
xk = stepfun(k,0)-2*stepfun(k,1)+stepfun(k,2);
hk = stepfun(k,0)-stepfun(k,1);
yk = conv(xk,hk);
plot(yk);
