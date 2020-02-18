function [prob_est,stderr_of_est]=lastname_firstname_hw1_prob1(M,N)
%% generating M samples and calulating derangments in theses samples.
%%repition allowed i.e. same sample can be picked multiple times 

test=1:N;
sample_derang=0;
for i=1:M
   a=randperm(N,N); %generate random permutation
   chk=zeros(1,N);
   chk(a==test)=1; %check for derangements
   if sum(chk)>0
       sample_derang=sample_derang+1;
   end
end
sample_derang; %total number of drenagments in the sample
prob_est=sample_derang/M;

%% Standard Error Computation
stderr_of_est=sqrt((1/(M*(M-1)))*(sample_derang*(1-prob_est)^2+(M-sample_derang)*prob_est^2));

end