r=1;
M=1e4;
azm=rand(M,1)*2*pi;

%% cos doesnt work :(
int_a = -1;
int_b = 1;
int_1 = (1-int_a).*rand(M,1) + int_a;
polar=acos(int_1);
% polar=rand(M,1)*pi;

%%
% rvals = 2*rand(M,1)-1;
% polar = asin(rvals); %%% Why doesnt acos work? which has range -1 to 1. >>>>>>>>>>>>

% polar=(1/(cos(2*rand(M,1)-1)))';
% hist(cos(polar));
% [polar,azm]=meshgrid(polar,azm);
[X,Y,Z]=sph2cart(azm,polar,r);
Z=cos(polar);

X=sin(polar).*cos(azm);
Y=sin(polar).*sin(azm);
Z=cos(polar);
ind=ones(size(X));
scatter3(X,Y,Z);
al=[X Y Z];
q1=al((X>0 & Y>0 & Z>0),:);
q2=al((X>0 & Y>0 & Z<0),:);
q3=al((X>0 & Y<0 & Z>0),:);
q4=al((X>0 & Y<0 & Z<0),:);
q5=al((X<0 & Y>0 & Z>0),:);
q6=al((X<0 & Y>0 & Z<0),:);
q7=al((X<0 & Y<0 & Z>0),:);
q8=al((X<0 & Y<0 & Z<0),:);
% surf(X,Y,Z);
% alpha=1;
% polar=acos(2*rand(M,1).^(1/alpha)-1);
% azm=rand(M,1)*2*pi;
% theta=linspace(0,w*pi);
% phi=linspace(-pi/2,pi/2);
% [theta,phi]=meshgrid(theta,phi);
% rho=2;