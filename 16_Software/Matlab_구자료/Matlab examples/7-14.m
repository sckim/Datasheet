clear all
k=-5:10;
x=(0.8).^k.*stepfun(k,0); 
y=(0.8).^(k-2).*stepfun(k,2);
v=(0.8).^(k+2).*stepfun(k,-2);
w=(0.8).^(k+2).*stepfun(k,0);
figure %  
subplot(4,1,1),stem(k,x),axis([-5 10 0 1.5]);
title('신호 x[k]');xlabel('k');
subplot(4,1,2),stem(k,y),axis([-5 10 0 1.5]);
title('신호 y[k]');xlabel('k');
subplot(4,1,3),stem(k,v),axis([-5 10 0 1.5]);
title('신호 v[k]');xlabel('k');
subplot(4,1,4),stem(k,w),axis([-5 10 0 1.5]);
title('신호 w[k]');xlabel('k');
