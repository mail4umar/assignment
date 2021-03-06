function [probs]=lastname_firstname_hw3_prob2(alpha,beta,lambda,mu,num_ensemble,t_final)
k=170;

% T=2e2;
T=0.2e2;
t=0;
nk=zeros((2*k),1);
nk(2)=num_ensemble; % this is off state of 0. states are in the following sequence: 0 0' 1 1'...


%% Building C matrix
C=zeros(2*k,2*k);
js=3:2:(2*k-1);                 % REMEMBER 1 means 0!!
is=1:2:(2*k-3);
ind = sub2ind(size(C),is,js);
C(ind)=lambda;
js=2:2:(2*k);
is=1:2:2*k;
ind = sub2ind(size(C),is,js);
C(ind)=beta;
ind = sub2ind(size(C),js,is);
C(ind)=alpha;
js=1:2*k-2;
is=3:2*k;
ind = sub2ind(size(C),is,js);
ks=1:2*(k-1);
ks=ceil(ks/2);
mus=mu*ks;
C(ind)=mus;
rowsum=sum(C,2);
is=1:2*k;js=1:2*k;
ind = sub2ind(size(C),is,js);
C(ind)=-rowsum;
% nk=ceil((0:2*(k-1))/2);
% nk=[0 nk]'; % To multiply by nk
Ckk=diag(C);
clear ind is js ks mus rowsum
i=0;ii=0;
ts=[];
nks=[];
taus=[];
RNA=[];
while t<t_final
    %% Time to transition
    U1=rand(1);
    tau=-log(U1)./(sum(-nk.*Ckk));
    %% Which state will transition
    i=i+1;
    U2=rand(1);
    normedrates=nk.*-Ckk/(sum(-nk.*Ckk));
    chosen_state=min(find(cumsum(normedrates)>=U2)); % This can sometimes be empty
    %% Target State
    U3=rand(1);
    rates = C(chosen_state,:);
    rates(chosen_state)=0;
    normedrates=rates/sum(rates);
    target_state=min(find(cumsum(normedrates)>=U3));
    %% update
    nk(chosen_state)=nk(chosen_state)-1;
    nk(target_state)=nk(target_state)+1;
    t=t+tau;
    % ts(i)=t;
    NK=nk;
    NK=reshape(NK,[2,length(nk)/2]);
    NK=sum(NK)';
    if num_ensemble<2
        RNA(i)=find(NK==1)-1;
    end
    if t>5*T % To only include values greater than 5T
        ii=ii+1;
        nks(:,ii)=NK;
        taus(ii)=tau;
    end
end
%% Calculate probabilities
tauss=repmat(taus,k,1);
probs=nks.*tauss;
probs=sum(probs,2)./sum(sum(probs));

% plot(RNA);
end