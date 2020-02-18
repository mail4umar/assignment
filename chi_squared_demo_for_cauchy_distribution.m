
nsample=1000000;        % number of samples 

U=rand(nsample,1);      % generate uniform RVs all at once
X=tan(pi*(U-0.5));      % transform to Cauchy dist

dx=0.1;                 % width of  bins
nbinhalf=50;            % half-width of binning region, number of bins

%
% compute bin *edges*
%
binedges=-nbinhalf*dx+dx/2:dx:nbinhalf*dx-dx/2; 

%
% make larger figure fit screen
%
scrnsize=get(groot,'ScreenSize');
hf = figure(1);
set(hf, 'Position',[0.25*scrnsize(3) 0.25*scrnsize(4) 0.5*scrnsize(3) 0.5*scrnsize(4)])

%
% plot a histogram of values
%
histogram(X,binedges);
a=gca;
set(a,'linewidth',1,'FontSize',15);

%
% plot theoretical distribution
%
hold on;
x=linspace(-nbinhalf*dx,nbinhalf*dx,5*nbinhalf+1);
y=nsample*dx./(pi*(1+x.^2));
plot(x,y,'linewidth',2);
hold off;

%
% set up bins for Chi2-test; use cdf to make equal probability bins
%
numchi2=10;
chi2bins=tan(pi*((0:numchi2)/numchi2-0.5));

%
% count samples falling in bins
%
obs=histcounts(X,chi2bins);
exp=nsample/numchi2*ones(1,numchi2);

%
% calculate chi2 value
%
chi2val=sum((obs-exp).^2./exp);

%
% calculate chi2 tail probability
%
Pval=chi2cdf(chi2val,numchi2-1,'upper');

fprintf('\n Direct Chi-squared p-value is %6.4f\n',Pval);

%
% perform chi2 goodness of fit test
%
[H,P,stats]=chi2gof(X,'edges',chi2bins,'expected',exp);

fprintf(' chi2gof Chi-squared p-value is %6.4f\n\n',P);