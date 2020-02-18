function [prob_est,stderr_of_est]=lastname_firstname_hw1_prob2(M,K,p)


KK=repmat(K,1,M); % generate M samples
[hndrd_count]= exprmnt(KK,p);
prob_est=hndrd_count/M;
stderr_of_est=sqrt((1/(M*(M-1)))*(hndrd_count*(1-prob_est)^2+(M-hndrd_count)*prob_est^2));
end

%% Experiment Function
% Starts with a big vector of length M with same values (K).
function [final_K]= exprmnt(KK,p)
p=1-p;
while any(KK<100)
    randa=rand(size(KK));
    randa(randa>p)=1;
    randa(randa<p)=-1;
    KK=KK+randa;
    KK(KK==0)=[]; %get rid of those experiments that reach 0
    KK(KK==100)=NaN; %make those that reach 100 equal to infinity
end
final_K=length(KK);
end