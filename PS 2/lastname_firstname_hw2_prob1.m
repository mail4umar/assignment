function [samples] = lastname_firstname_hw2_prob1(M)
xs=sqrt(2);
A=2*sqrt(2)*pi*xs*exp(-xs^2/4);
%%
lambda=2; % set parameters
Multiplyer=1;
i=1;
samples=[];
while length(samples)<M
N=10^Multiplyer*M;
% X=real(sqrt(-lambda^2*log(-(rand(N,1))))); % Does the A fit here? or can we treat it later?
X=(sqrt(-4*log(1-A*(rand(N,1)))));
X=X(~imag(X));
U=rand(length(X),1).*X;
p=sqrt(2)*pi*X.^2.*exp(-(X.^2/2));
Accepted=X(U<=(p./A)); % Does the A fit here?
if length(Accepted)>=M
    samples=[samples Accepted];
    break
end
i=i+1;
Multiplyer=(Multiplyer+1);
end
% hist(samples);
% XX=0:0.01:6;
% figure(2),plot(XX,(sqrt(2)*pi*(XX.^2).*exp(-(XX.^2)./2)));
% figure(2),hist((sqrt(2)*pi*(XX.^2).*exp(-(XX.^2)./2)));
% figure(3)
% scatter(X,abs(Accepted));
% lalu=abs(Accepted);

end


