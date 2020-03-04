%
% program to test Metropolis sampling
% goal is to generage a Gaussian distribution with prescribed variance
% 
% no MMC probability histogram at this stage
%
% 12/29/02 William L. Kath
% 1/17/12 updated
% 2/7/2020 updated

sigma=1.0;    % standard deviation of target distribution
epsilon=1.0 ;   % size parameter of the jump
n=100000;        % number of of times to iterate the Metropolis algorithm
trials=100;      % number of chains to run in parallel
nbin2=50;         % binning parameters
nbins=2*nbin2+1;

bin=zeros(1,nbins);
nsigma=6;           % sets range -- number of standard deviations
maxx=nsigma*sigma;

x=zeros(n,trials);  % vector to save things

accept=0;
x(1,:)=sigma*randn(1,trials);   % starting value

for j=2:n
    temp=x(j-1,:)+epsilon*2*(rand(1,trials)-0.5);   % new candidate
    ratio=exp((-temp.^2+(x(j-1,:)).^2)/2/sigma^2);  % Hastings acceptance ratio
    z=rand(1,trials);                               % uniform random
    flag=z<ratio;                                   % accept flags
    x(j,:)=temp.*flag+x(j-1,:).*(1-flag);           % accept or keep old value
    accept=accept+sum(flag);                        % keep track of number accepted
end
fprintf(1,'%6.1f per cent accepted\n',accept/trials/n*100);

nplot=200;

t=(1:nplot);

scrsz = get(0,'ScreenSize');
f1=figure(1);
set(f1,'Position',[1*scrsz(3)/32 1*scrsz(4)/16 scrsz(3)*7/16 scrsz(4)*6/8]);

%
% plot one chain
%
subplot(2,1,1),plot(t,x(1:nplot,1),'linewidth',2);
a=gca;
set(a,'FontSize',16);
ylabel('MCMC','FontSize',16);

%
% compare with random samples
%
subplot(2,1,2),plot(t,randn(nplot,1),'linewidth',2);
a=gca;
set(a,'FontSize',16);
ylabel('random','FontSize',16);

% bin results for plotting pdf
%
xr=round(x/(nsigma*sigma)*nbin2)+nbin2+1;
dx=12*sigma/nbins;
for j=1:n
    for k=1:trials
        if ((xr(j,k)>0)&(xr(j,k)<nbins)) 
            bin(xr(j,k))=bin(xr(j,k))+1;
        end
    end
end
bin=bin/trials/n/dx;

f2=figure(2);
set(f2,'Position',[8*scrsz(3)/16 1*scrsz(4)/8 scrsz(3)*7/16 scrsz(4)*4/8]);

% compare with exact
t=[-nbin2:nbin2]/nbin2*nsigma*sigma;
semilogy(t,exp(-t.^2/2/sigma^2)/sqrt(2*pi*sigma^2),t,bin,'linewidth',2);
a=gca;
set(a,'FontSize',16);