r=1;
M=1e3;
azm=rand(M,1)*2*pi;

%% cos doesnt work :(
int_a = -1;
int_b = 1;
int_1 = (1-int_a).*rand(M,1) + int_a;
polar=acos(int_1);

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

scatter3(X,Y,Z);
% surf(X,Y,Z);
alpha=1;
polar=acos(2*rand(M,1).^(1/alpha)-1);
azm=rand(M,1)*2*pi;
% theta=linspace(0,w*pi);
% phi=linspace(-pi/2,pi/2);
% [theta,phi]=meshgrid(theta,phi);
% rho=2;