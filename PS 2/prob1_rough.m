x=0:0.1:10;
lambda=2;
% g=2*(x./lambda^2).*exp(-(x/lambda).^2);
% plot(x,g)
xs=sqrt(2);
A=2*sqrt(2)*pi*xs*exp(-xs^2/4);
%%
N=1e4;

X=real(sqrt(-lambda^2*log(-(rand(N,1))))); % Does the A fit here? or can we treat it later?
% X=A*(sqrt(-lambda^2*log(-rand(N,1)))); % generate exponential samples
U=rand(N,1).*X;
p=sqrt(2)*pi*X.^2.*exp(-(X.^2/2));
% z=zeros(size(U));
% z(A*U<=p)=1;
% Accepted=U.*z;
Accepted=U(A.*U<=p);
X_accepted=X(A.*U<=p);
Accepted(Accepted==0)=[];
% figure(4)
% hist(Accepted)
s=length(Accepted);
sample2=sqrt(randn(s,1).^2+randn(s,1).^2+randn(s,1).^2);
h=kstest2(Accepted,sample2)
hist(Accepted)
figure(2),hist(sample2)
% figure(2)
% scatter(X,abs(Accepted));
% lalu=abs(Accepted);
% 
% figure(3)
% scatter(X,p)
% hold on
% scatter(X,U)

%% KS tests multiple times
M=1e4;
times=1e4;
fail=0;
for i=1:times
[samples] = lastname_firstname_hw2_prob1(M);
sample2=sqrt(randn(M,1).^2+randn(M,1).^2+randn(M,1).^2);

h=kstest2(samples,sample2);
if h==1
    fail=fail+1;
end
end
fail
% hist(sample2);
% figure,hist(sample)

