n=100;          % number of coin flips  
x=0:n;          % vector of possible number of heads
p=0.5;          % unbiased probability of heads

m=85;           % threshhold


nv=n*ones(size(x));         % vector of all n's
c=gamma(nv+1)./(gamma(x+1).*gamma(nv-x+1));     % binomial coefficients
probs=c.*exp(x*log(p)+(nv-x)*log(1-p));         % vector of probabilities    

indx=x<m;                   % index below threshhold
probtail=probs;             
probtail(indx)=0;           % cut off values < threshhold

%
%
%
figure(1)
semilogy(x,probtail,'o','linewidth',2);
axis([70 100 0 2*max(probtail)]);
a=gca;
set(a,'linewidth',1,'FontSize',14);
xlabel('num heads','FontSize',16);
ylabel('probability','FontSize',16);

p=0.85;
prob85=c.*exp(x*log(p)+(nv-x)*log(1-p));

p=0.75;
prob75=c.*exp(x*log(p)+(nv-x)*log(1-p));

p=0.95;
prob95=c.*exp(x*log(p)+(nv-x)*log(1-p));


%
% for plotting purpose make a jump at threshhold 
%
x2=[x(1:m) x(m+1) x(m+1:end)];
probtail2=[probtail(1:m) probtail(m) probtail(m+1:end)];


figure(2)
subplot(2,1,1),plot(x2,probtail2,'o--','linewidth',2,'MarkerSize',10);
legend('I_m(z_N)p(z_N)','Location','NorthWest','Fontsize',16);
axis([75 95 0 1.1*max(probtail2)]);
a=gca;
set(a,'linewidth',1,'FontSize',14);
xlabel('z_N')
subplot(2,1,2),plot(x,prob85,'o--',x,prob75,'o--',x,prob95,'o--','linewidth',2,'MarkerSize',10);
legend('p=0.85','p=0.75','p=0.95','Location','NorthWest','FontSize',16);
axis([75 95 0 1.1*max([prob75 prob85 prob95])]);
a=gca;
set(a,'linewidth',1,'FontSize',14);
xlabel('z_N')