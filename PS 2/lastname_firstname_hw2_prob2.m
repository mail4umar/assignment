function [IQR] = lastname_firstname_hw2_prob2(N,M,nu)
Is=[];
for i=1:N
I_hat=mean(rand(M,1).^(-1/nu));
Is=cat(1,Is, I_hat);
end
Q2=median(Is);
% q1=Is(Is<Q2);
Q1=median(Is(Is<Q2));
Q3=median(Is(Is>Q2));
IQR=Q3-Q1;
end
