% function [prob_est,sterr_of_est]=lastname_firstname_hw1_prob2(M,K,p)
clear all
clc

M=1e5; K=50; p=0.49;

%% generate M samples
hndrd_count=0;

KK=repmat(K,1,M);
[hndrd_count]= exprmnt(KK,p);
prob_est_1=hndrd_count/M


%% generate M samples
hndrd_count=0;
for i=1:M
[final]= one_exp(K,p);
if final==100
    hndrd_count=hndrd_count+1;
end
end
prob_est_2=hndrd_count/M
function [final_K]= one_exp(K,p)
while K<100 && K>0
if rand()<p
    K=K+1;
else
    K=K-1;
end
end
final_K=K;
end

function [final_K]= exprmnt(KK,p)
p=1-p;
while any(KK<100)
    randa=rand(size(KK));
    randa(randa>p)=1;
    randa(randa<p)=-1;
    KK=KK+randa;
    KK(KK==0)=[];
    KK(KK==100)=NaN;
end
final_K=length(KK);
end
% end