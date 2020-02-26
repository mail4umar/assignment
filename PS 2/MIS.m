% The format is copied from the uploaded example
% importance sampling demo, sum of Gaussians
%

rng('default');
rng('shuffle');

%
% number of trials
%
trials = 1e4;

%
% number of steps
%
n=20;

%
% biasing parameters
%

bias = 1:12;

%
% plotting parameters for different biasings
%

plotstr=['bo' 'ro' 'ko' 'go' 'co' 'mo' 'go' 'ro' 'mo' 'bo' 'co' 'ko'];
linestr=['b-' 'r-' 'k-' 'g-' 'c-' 'm-' 'g-' 'r-' 'm-' 'b-' 'c-' 'k-'];

na=length(bias);
nbins=100;              % binning parameters
maxx=20;
dx=maxx/nbins;
xbins=(dx/2:dx:maxx-dx/2);

%
% vectors to save results
%
binavg=zeros(1,nbins);
cdfavg=zeros(1,nbins);
cdcavg=zeros(1,nbins);
misvar=zeros(1,nbins);
nums=zeros(1,nbins);

sz = get(0,'ScreenSize');
wid=sz(3);
hyt=sz(4);

sigma2=n;

% start loop here

%
% loop through biasing parameters
%
for ka=1:na
% for ka=1:1
    
    sums=zeros(1,trials);
    ratios=ones(na,trials);
    
    %
    % now loop through adding the Gaussians
    %
    for j=1:n
        
        fprintf(1,' bias %4i, pass %4i\n',ka,j)
        if j==1
            dis=ones(trials,1);
            polar = acos(2*rand(trials,1)-1);
            ZZZ=1;
        else
            zzz=2*rand(trials,1).^(1/bias(ka))-1;
            polar=acos(zzz);
            dis=sqrt(dis.^2+1-2*dis.*cos(pi-polar));
            z=cos(polar);
            %             ZZZ=(((z+1)/2).^(1-alpha))/alpha;
        end
        %         liklihd=liklihd.*ZZZ;
        %
        %         z=randn(1,trials);          % do all trials at once
        %         x=bias(ka)*ones(size(z))+z; % add the bias
        
        %
        %   calculate all likelihood ratios for these samples
        %
        for kk=1:na
            if j==1
                ratio=1;
            else
                %% DIFFERENTIATE BETWEEN FIRST POLAR AND OTHERS
                ratio=(((z+1)/2).^(1-bias(kk)))/bias(kk);
            end
            ratios(kk,:)=ratios(kk,:).*ratio';
        end
        
        sums=dis';
        
    end
    fprintf(1,'\n');
    
    %
    %   bin the results
    %
    
    %
    % balance heuristic
    %
    
    weight=1./(sum(1./ratios,1));
    
    %
    % bin the results
    %
    
    bintmp=zeros(1,nbins);
    binold=zeros(1,nbins);
    for j=1:nbins
        
        %
        % make an indicator function for every bin
        %
%         indx=find((-maxx+(j-1)*dx)<sums&sums<=(-maxx+j*dx));
        indx=find((j*dx)<sums&sums<=((j+1)*dx));
        indc=find(sums<=((j+1)*dx));
        indr=find(sums>((j+1)*dx));
%         indc=find(sums<=(-maxx+j*dx));
%         indr=find(sums>(-maxx+j*dx));
        if ~isempty(indx)
            binavg(j)=binavg(j)+sum(weight(indx))/trials;
            bintmp(j)=sum(weight(indx))/trials;
            binold(j)=sum(ratios(ka,indx))/trials;          % unweighted
        end
        nums(j)=nums(j)+length(weight(indx));
        
        estim=sum(weight(indx))/trials;                     % estimated value in bin
        %
        % Now set up and compute variance; get contribution from each
        % biasing distribution
        %
        tmpweight=zeros(size(weight));
        tmpweight(indx)=weight(indx);
        misvar(j)=misvar(j)+sum((tmpweight-estim*ones(size(tmpweight))).^2)/(trials*(trials-1));
        
        %
        % these lines compute cdf and 1-cdf
        %
        cdfavg(j)=cdfavg(j)+sum(weight(indc))/trials;
        cdcavg(j)=cdcavg(j)+sum(weight(indr))/trials;
    end
    %
    % Long equation calc
    %
    N=20;
    rmax=maxx;
    r=1;
    i=1;
    p_check=[];
    % for r=0:0.2:rmax
    for r=xbins
        ro=r/rmax;
        L= @(x) 1/tanh(x)-1/x-ro;
        x0=0.5;
        linv = fzero(L,x0);
        p_check(i)=ro*linv/(rmax*sqrt((pi/(2*N^3))*(1-ro^2-2*ro/(linv)))) * exp(-N*ro*linv) * (sinh(linv)/linv)^N;
        i=i+1;
    end
    %
    % weighted probabilities
    %
    f1=figure(1);
    set(f1,'Position',[0.025*wid 0.525*hyt wid/3 hyt/3]);
    semilogy(xbins,bintmp/dx,'linewidth',2.0,'MarkerSize',12);
    a=gca;
    set(a,'linewidth',1.0,'FontSize',14);
    xlabel('z','FontSize',16);
    ylabel('weighted probabilities');
    drawnow;
    hold on;
    f2=figure(2);
    set(f2,'Position',[0.35*wid 0.525*hyt wid/3 hyt/3]);
    %     semilogy(xbins,exp(-xbins.*xbins/(2*sigma2))/sqrt(2*pi*sigma2),'r-',xbins,binavg/dx,'linewidth',2.0);
    semilogy(xbins,p_check,'r-',xbins,binavg/dx,'linewidth',2.0);
    a=gca;
    set(a,'linewidth',1.0,'FontSize',14);
    xlabel('z','FontSize',16);
    ylabel('weighted probability');
    f3=figure(3);
    set(f3,'Position',[0.675*wid 0.525*hyt wid/3 hyt/3]);
    semilogy(xbins,binold/dx,linestr(2*ka-1:2*ka),xbins,binold/dx,plotstr(2*ka-1:2*ka),'linewidth',2.0,'MarkerSize',12);
    a=gca;
    set(a,'linewidth',1.0,'FontSize',14);
    xlabel('z','FontSize',16);
    ylabel('unweighted probabilities');
    hold on;
    pause(1);
end

%
% plot composite distribution
%
binavg=binavg/dx;
figure(1);
% semilogy(xbins,binavg,xbins,exp(-xbins.*xbins/(2*sigma2))/sqrt(2*pi*sigma2),'r-','linewidth',2);
semilogy(xbins,binavg,xbins,p_check,'r-','linewidth',2);

a=gca;
set(a,'linewidth',1.0,'FontSize',14);
xlabel('z','FontSize',16);
ylabel('weighted and exact probability','FontSize',16);
drawnow;

hold off;

f4=figure(4);
set(f4,'Position',[0.025*wid 0.025*hyt wid/3 hyt/3]);

plot(xbins,binavg,xbins,p_check,'linewidth',2);
a=gca;
set(a,'linewidth',1.0,'FontSize',14);
xlabel('z','FontSize',16);
ylabel('weighted and exact probability','FontSize',16);

f5=figure(5);
set(f5,'Position',[0.35*wid 0.025*hyt wid/3 hyt/3]);
plot(xbins,sqrt(misvar)./binavg,'linewidth',2);
a=gca;
set(a,'linewidth',1.0,'FontSize',14);
xlabel('z','FontSize',16);
ylabel('coefficient of variation','FontSize',16);

f6=figure(6);
set(f6,'Position',[0.675*wid 0.025*hyt wid/3 hyt/3]);
semilogy(xbins,nums,'linewidth',2);
a=gca;
set(a,'linewidth',1.0,'FontSize',14);
xlabel('z','FontSize',16);
ylabel('number of samples per bin','Fontsize',16);

figure(1);
hold off;
figure(2);
hold off;
figure(3);
hold off;
figure(4);
hold off;
figure(5);
hold off;
figure(6);
hold off;
