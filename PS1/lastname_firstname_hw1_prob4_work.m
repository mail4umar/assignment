% function [chi2pvals]=lastname_firstname_hw1_prob4(M,N,a,nbins)
N=1000;
M=1;
x=rand(M,N);
a=1;
finv=-log(1-x)/a;
[y,x]=ecdf(finv);
XXX=0:0.01:8;
p2=1-exp(-a*XXX);
plot(x,y);hold on;
plot(XXX,p2)
% h = chi2gof(p); % 0 means normal
% end