function [samples] = lastname_firstname_hw2_prob1(M)
xs=sqrt(2);lambda=2;
% A=2*sqrt(2)*pi*xs*exp(-xs^2/4)
% A=4/sqrt(pi)*exp(-0.5)
A=sqrt(2/pi)*(xs/2)*lambda^2*exp(-(xs^2/2)+(xs^2/lambda^2));
%%
samples=[];
N=M;
while length(samples)<M
% X=real(sqrt(-lambda^2*log(-(rand(N,1))))); % Does the A fit here? or can we treat it later?
X=2*sqrt(-log(1-(rand(N,1))));
% X=(sqrt(-4*log(1-(rand(N,1)))));
X=X(~imag(X));

U=rand(length(X),1).*X;

%% Change
U=rand(length(X),1)*2.*X./(lambda^2).*exp(-X.^2./lambda^2);
%%
p=sqrt(2/pi)*X.^2.*exp(-((X.^2)/2));
Accepted=X(U<=p./A); % Does the A fit here?
samples=[samples;Accepted];
end
samples=samples(1:M);
hist(samples);

end


