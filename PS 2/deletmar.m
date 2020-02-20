% l=2
% fun1 = @(x) 2*x./(l^2).*exp(-x.^2./l^2); % function
% fun2= @(x) sqrt(2/pi)*x.^2.*exp(-x.^2./2); % function
% x=0:0.1:10;
% A=4/sqrt(pi)*exp(-0.5)
% plot(x,A.*fun1(x));hold on
% plot(x,fun2(x))



%% KS tests multiple times
M=1e4;
times=1e4;
P=[];
fail=0;
for i=1:times
[maxwell_est] = lastname_firstname_hw2_prob1(M);
maxwell=sqrt(randn(M,1).^2+randn(M,1).^2+randn(M,1).^2);

[h,p]=kstest2(maxwell,maxwell_est);
P=[P;p];
fail=fail+h;
end
fail
histogram(maxwell,20,'EdgeColor','blue','FaceColor','blue');hold on
histogram(maxwell_est,20,'EdgeColor','green','FaceColor','green','FaceAlpha',0.2)
% figure,hist(P,20);
% hist(P,5);

