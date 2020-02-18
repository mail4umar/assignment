r=1;
M=1e3;
polar=rand(M,1)*2*pi;
int_a = -1;
int_b = 1;
int_1 = (int_b-int_a).*rand(M,1) + int_a;
azm=acos(int_1);
R=repmat(r,M,1);
% hist(cos(azm));
[polar,azm]=meshgrid(polar,azm);
[X,Y,Z]=sph2cart(polar,azm,r);
surf(X,Y,Z);
% scatter(X,Y);

% theta=linspace(0,w*pi);
% phi=linspace(-pi/2,pi/2);
% [theta,phi]=meshgrid(theta,phi);
% rho=2;