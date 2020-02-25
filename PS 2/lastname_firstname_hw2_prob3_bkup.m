trials=1e4;
steps=20;

% for alpha=1:7

alpha=1;
polar=zeros(steps,1);
azm=zeros(steps,1);
%% First step
D=zeros(trials,1);
liklihd=zeros(trials,1);
for i=1:trials
r=1;

%% Next steps
M=steps;
zzz=2*rand(M,1).^(1/alpha)-1;
polar=acos(zzz);
polar(1) = acos(2*rand()-1);
azm=rand(M,1)*2*pi;
x=sin(polar).*cos(azm);
y=sin(polar).*sin(azm);
z=cos(polar);
X=sum(x);
Y=sum(y);
Z=sum(z);
distance=sqrt(X^2+Y^2+Z^2);
D(i)=distance;
ZZZ=(((z+1)/2).^(1-alpha))/alpha;
liklihd(i)=prod(ZZZ);
end
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
