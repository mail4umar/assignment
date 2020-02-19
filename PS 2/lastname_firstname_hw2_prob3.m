trials=1e4;
% for alpha=1:7
alpha=1;
steps=20;
polar=zeros(steps,1);
azm=zeros(steps,1);
%% First step
r=1;
azm(1)=rand()*2*pi;
polar(1) = acos(2*rand()-1);

%% Next steps
D=[];
for i=1:trials
M=steps-1;
polar(2:end)=acos(2*rand(M,1).^(1/alpha)-1);
azm(2:end)=rand(M,1)*2*pi;
x=sin(polar).*cos(azm);
y=sin(polar).*sin(azm);
z=cos(polar);
X=sum(x);
Y=sum(y);
Z=sum(z);
distance=sqrt(X^2+Y^2+Z^2);
D=[D;distance];
end
% hist(D)

%% Binning
bins=100;
delt=steps/bins;
range_end=0;
prob=[];
COV=[];
for i=1:bins
   range_start=range_end;
   range_end=range_start+delt;
   interim=D(D>=range_start & D<=range_end); 
   
   prob(i)=length(interim);
   COV(i)=std( interim) / sqrt( length( interim ))/prob(i);
end

%% Plotting
plot(prob);

% hold on
% end

%% large equation
clear X Y Z
N=1e2;
rmax=20;
r=1;
i=1;
p_check=[];
for r=0:delt:rmax
ro=r/rmax;
L= @(x) 1/tanh(x)-1/x-ro;
x0=0.5;
linv = fzero(L,x0);
p_check(i)=ro*linv/(rmax*sqrt((pi/(2*N^3))*(1-ro^2-2*ro/(linv)))) * exp(-N*ro*linv) * (sinh(linv)/linv)^N;
i=i+1;
end

semilogy(p_check)
hold on
semilogy(prob)

%% Coefficient of variation
figure,plot(COV)