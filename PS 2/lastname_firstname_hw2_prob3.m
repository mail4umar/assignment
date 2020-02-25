trials=1e5;
steps=20;

% for alpha=1:7

alpha=5;
polar=zeros(trials,1);
azm=zeros(trials,1);
%% First step
liklihd=ones(trials,1);
for i=1:steps
if i==1
    distance=ones(trials,1);
    polar = acos(2*rand(trials,1)-1);
    ZZZ=1;
else
zzz=2*rand(trials,1).^(1/alpha)-1;
polar=acos(zzz);
distance=sqrt(distance.^2+1-2*distance.*cos(pi-polar));
z=cos(polar);
ZZZ=(((z+1)/2).^(1-alpha))/alpha;
end
liklihd=liklihd.*ZZZ;
end
D=distance;
% hist(D)

%% Binning
bins=100;
delt=steps/bins;
range_end=0;
prob=zeros(bins,1);
meansave=zeros(bins,1);
sigsave=zeros(bins,1);
COV=[];
for i=1:bins
   range_start=range_end;
   range_end=range_start+delt;
   interim=1*(D>=range_start & D<=range_end); 
   p=interim.*liklihd;
   prob(i)=sum(p);
   m=mean(p);                  % find the sample mean
   s=sqrt(var(p));             % and the standard deviation
   meansave(i)=m;              % save them
   sigsave(i)=s; 
end

%% Plotting
prob=prob./(trials*delt);
plot(prob);

% hold on
% end

%% large equation
clear X Y Z
N=20;
rmax=20;
r=1;
i=1;
p_check=[];
for r=0:0.2:rmax
ro=r/rmax;
L= @(x) 1/tanh(x)-1/x-ro;
x0=0.5;
linv = fzero(L,x0);
p_check(i)=ro*linv/(rmax*sqrt((pi/(2*N^3))*(1-ro^2-2*ro/(linv)))) * exp(-N*ro*linv) * (sinh(linv)/linv)^N;
i=i+1;
end

semilogy(p_check')
hold on
semilogy(prob)

%% Coefficient of variation
% COV=sigsave./meansave
% figure,plot(COV)
