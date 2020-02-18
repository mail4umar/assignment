% function [prob_est,stderr_of_est]=lastname_firstname_h1_prob1(M,N)

M=1e7; N=12;
all_num=1:N;
all_perm= perms(all_num);
all_num_big_vector=repmat(all_num,[size(all_perm,1),1]);
chk=zeros(size(all_num_big_vector));
chk(all_num_big_vector==all_perm)=1;
chk( all(~chk,2), : ) = [];
non_derang=size(chk,1); 
clear all_num_big_vector 

prob_est=1-non_derang/size(all_perm,1)

% i=randsample(size(all_perm,1),M,1);
% sample_perm=all_perm(i,:);
% all_num_big_vector=repmat(all_num,[size(sample_perm,1),1]);
% chk_sample=zeros(size(all_num_big_vector));
% chk_sample(all_num_big_vector==sample_perm)=1;
% chk_sample( all(~chk_sample,2), : ) = [];
% derang_sample=size(chk_sample,1);
% 
% SE=sqrt((1/(M*(M-1)))*(derang_sample*(1-prob_est)^2+(M-derang_sample)*prob_est^2))
% SD=sqrt(prob_est*(1-prob_est)/M)
% end

%% method 2
% all_perms=factorial(N)
% derang=notN(N)
% prob_est=derang/all_perms

% function [a]= notN(q) %% https://en.wikipedia.org/wiki/Derangement
% Q=0:q;
% w=(-1).^Q./factorial(Q);
% a=sum(w)*factorial(q);
% end