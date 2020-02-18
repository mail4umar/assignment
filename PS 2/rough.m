a=1; % set parameters
M=1000;
N=1000;

% X=-log(1-rand(N,1))/a; % generate exponential samples
% X=sqrt(-lambda^2*log(-rand(N,1)));
X=abs(sqrt(-4*log(-rand(N,1))));
figure(1);
[f,y]=ecdf(X); % numerical CDF plot
YY=2*(y./lambda^2).*exp(-(y/lambda).^2);
plot(y,YY,y,f,'linewidth',2);
ax=gca;
set(ax,'linewidth',1,'FontSize',14);
xlabel('x','FontSize',16);
ylabel('CDF','FontSize',16);
set(ax,'PlotBoxAspectRatio',[1.0 0.4 1.0]);