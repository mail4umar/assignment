%% INTIAliZATION
clc
clear all
iter=5e5;
decode=true;
rejec_limit=1e3;

%% CALCULATE REFERENCE TRANSITION PROBABILITY MATRIX
fileID = fopen('war.txt','r');
formatSpec = '%c';
A = fscanf(fileID,formatSpec);
C = unique(A);
transition_sum=zeros(length(C),length(C));
for x=1:length(A)-1
    y=x+1;
    X=A(x);
    Y=A(y);
    x_ind=find(C==X);
    y_ind=find(C==Y);
    transition_sum(x_ind,y_ind)=transition_sum(x_ind,y_ind)+1; % add one to the histogram
end
dens=sum(transition_sum,2);
dens=repmat(dens,1,length(dens));
P=transition_sum./dens;
P(P==0)=1e-14;

%%
fileID = fopen('encoded.txt','r');
formatSpec = '%c';
A = fscanf(fileID,formatSpec);

% LIKELIHOOD CALCULATION
f=C(randperm(length(C)));
X=A(1:end-1);
Y=A(2:end);
[~,x_ind]=ismember(X,f);
[~,y_ind]=ismember(Y,f);
sz = size(P);
ind = sub2ind(sz,x_ind,y_ind);
liklihood=sum(log(P(ind)));
L1=liklihood;
clear X Y x_ind y_ind ind

%%
acceptance=0;
consecutive_reject=0;
l1s=[];
l2s=[];
accs=[];
for i=1:iter
% FLIP TWO CHARACTERS
fnew=f;
two_chars = randperm(length(f),2);
fnew([two_chars(1) two_chars(2)])=fnew([two_chars(2) two_chars(1)]);

% LIKLIHOOD CALCULATION
X=A(1:end-1);
Y=A(2:end);
[~,x_ind]=ismember(X,fnew);
[~,y_ind]=ismember(Y,fnew);
sz = size(P);
ind = sub2ind(sz,x_ind,y_ind);
liklihood=sum(log(P(ind)));
L2=liklihood;
l2s(i)=L2;
l1s(i)=L1;

acc=min(exp(L2-L1),1);          % acceptance probability
accs(i)=acc;
z=rand;                         % get uniform RV
if z<acc                        % check acceptance
    f=fnew;
    L1=L2;
    acceptance=acceptance+1;
    consecutive_reject=0;
else
    consecutive_reject=consecutive_reject+1;
end
if consecutive_reject>rejec_limit
    break
end
end

% INITIAL DECODING
if decode==true
for x=1:length(A)-1
    X=A(x);
    x_ind=find(f==X);
    A(x)=C(x_ind);
end
end