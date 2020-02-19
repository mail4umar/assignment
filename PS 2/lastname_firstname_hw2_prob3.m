trials=1e4;
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
bin=100;


% for i=1:steps-1
%    polar(i+1)=polar(i)+acos(2*rand().^(1/alpha)-1);
%    azm(i+1)=azm(i)+rand(M,1)*2*pi;
% end