function [samples] = lastname_firstname_hw2_prob1(M)
xs=sqrt(2);lambda=2;
A=sqrt(2/pi)*(xs/2)*lambda^2*exp(-(xs^2/2)+(xs^2/lambda^2));
%%
samples=[];
N=M;
while length(samples)<M % Repeating until we get M samples
X=2*sqrt(-log(1-(rand(N,1))));
X=X(~imag(X)); % taking only real values
U=rand(length(X),1).*X;
%% Change
U=rand(length(X),1)*2.*X./(lambda^2).*exp(-X.^2./lambda^2);
%%
p=sqrt(2/pi)*X.^2.*exp(-((X.^2)/2));
Accepted=X(U<=p./A); % Checking the rejection sampling condition
samples=[samples;Accepted]; % Collecting all samples since in one go, we may not get all samples
end
samples=samples(1:M); %Making sure there are exact M samples.
hist(samples);
end


