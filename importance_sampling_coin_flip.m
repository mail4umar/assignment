trials=100000;      % number of trials
numflips=100;       % number of coin flips
threshhold=85;      % threshold for counting

pvals=0.7:0.01:0.95;       % biasing probabilities to try 
numpvals=length(pvals);

meansave=zeros(numpvals,1);     % vector to keep track of computed means
sigsave=zeros(numpvals,1);      % vector to keep track of computed standard deviation
sigexact=zeros(numpvals,1);     % vector to keep track of exact standard deviation

%
% calculate exact value
%
headvec=0:numflips;
nv=numflips*ones(size(headvec));
% Matlab function nchoosek has trouble with large numbers
% so use Gamma function instead
c=gamma(nv+1)./(gamma(headvec+1).*gamma(nv-headvec+1));
pheads=c/2^numflips;  
indx=headvec<threshhold;      % values less than cutoff
pheadtail=pheads;       
pheadtail(indx)=0;      % set values less than cutoff to zero
exact=sum(pheadtail);   % exact value is sum >= threshhold

for i=1:numpvals                % loop through biasing probabilities
    p=pvals(i);
    x=rand(numflips,trials);    % get all of the uniform random variables
    heads=1*(x<p);              % flags for heads
    numheads=sum(heads);        % sum for each trial
    indicat=(numheads>=threshhold);     % indicator function for sum >= threshold
    %
    % this line does all of the work --- it calculates the product of the
    % likelihood  ratios for every flip and then multiplies by the
    % indicator function
    %
    y=indicat.*(1/(2*p)*ones(1,trials)).^numheads.*(1/(2*(1-p))*ones(1,trials)).^(ones(1,trials)*numflips-numheads);
    m=mean(y);                  % find the sample mean
    s=sqrt(var(y));             % and the standard deviation
    meansave(i)=m;              % save them
    sigsave(i)=s;               

    m2=c.*exp(headvec*(-log(2*p))-(nv-headvec)*log(2*(1-p)))/2^numflips;
    m2(indx)=0;                         % set values less than cutoff to zero
    sigexact(i)=sqrt(sum(m2)-exact^2);  % exact variance
    
    
end



f1=figure(1);
%set(f1,'Position',[0.025*wid 0.525*hyt 0.45*wid 0.4*hyt]);
plot(pvals,meansave,[pvals(1) pvals(end)],[exact exact],'linewidth',2);
%plot(probs,means,probs,exacts,'linewidth',2.0)
xlabel('p');
ylabel('P(x >= m)');
a=gca;
set(a,'FontSize',18);
set(a,'linewidth',1.5);
set(a,'PlotBoxAspectRatio',[1.0 0.4 1.0]);


%
% plot sample standard deviation
%
figure(2);
semilogy(pvals,sigsave,pvals,sigexact,'linewidth',2);
xlabel('p');
ylabel('log10(\sigma)');
a=gca;
set(a,'FontSize',18);
set(a,'linewidth',1);
set(a,'PlotBoxAspectRatio',[1.0 0.4 1.0]);

%
% plot coefficient of variation
%
figure(3)
semilogy(pvals,sigsave./meansave,'linewidth',2);
xlabel('p');
ylabel('CV');
a=gca;
set(a,'FontSize',18);
set(a,'linewidth',1);
set(a,'PlotBoxAspectRatio',[1.0 0.4 1.0]);

%
% plot sample coefficient of variation
%
figure(4)
semilogy(pvals,(sigsave/sqrt(trials))./meansave,'linewidth',2);
xlabel('p');
ylabel('Sample CV');
a=gca;
set(a,'FontSize',18);
set(a,'linewidth',1);
set(a,'PlotBoxAspectRatio',[1.0 0.4 1.0]);
