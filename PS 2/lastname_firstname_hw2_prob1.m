function [samples] = lastname_firstname_hw2_prob1(M)
xs=sqrt(2);
A=2*sqrt(2)*pi*xs*exp(-xs^2/4);
%%
lambda=2; % set parameters
Multiplyer=1;
i=1;
while i<=100
N=10^Multiplyer*M;
X=real(sqrt(-lambda^2*log(-(rand(N,1))))); % Does the A fit here? or can we treat it later?
% X=A*(sqrt(-lambda^2*log(-rand(N,1)))); % generate exponential samples
U=rand(N,1).*X;
p=sqrt(2)*pi*X.^2.*exp(-(X.^2/2));
Accepted=U(U<=p./A); % Does the A fit here?
Accepted(Accepted==0)=[];

if length(Accepted)>=M
    samples=Accepted(1:M);
    break
end
i=i+1;
Multiplyer=(Multiplyer+1);
end
hist(samples);
XX=0:0.01:6;
figure(2),plot(XX,(sqrt(2)*pi*(XX.^2).*exp(-(XX.^2)./2)));
% figure(2),hist((sqrt(2)*pi*(XX.^2).*exp(-(XX.^2)./2)));
% figure(3)
% scatter(X,abs(Accepted));
% lalu=abs(Accepted);

end


