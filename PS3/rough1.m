%% CALCULATE REFERENCE TRANSITION PROBABILITY MATRIX
clc
clear all
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
D = unique(A);

% INITIAL DECODING
% rand_permutation=C(randperm(length(C)));
% newD=rand_permutation(1:length(D));
% for x=1:length(A)-1
%     X=A(x);
%     x_ind=find(D==X);
%     A(x)=newD(x_ind);
% end

% LIKELIHOOD CALCULATION
f=C(randperm(length(C)));
liklihood=1;
for x=1:length(A)-1
    y=x+1;
    X=A(x);
    Y=A(y);
    x_ind=find(f==X);
    y_ind=find(f==Y);
    liklihood=log(liklihood*P(x_ind,y_ind));
end
L1=liklihood;

acceptance=0;
for i=1:1e3
% FLIP TWO CHARACTERS
fnew=f;
two_chars = randperm(length(f),2);
fnew([two_chars(1) two_chars(2)])=fnew([two_chars(2) two_chars(1)]);

% LIKLIHOOD CALCULATION
liklihood=1;
for x=1:length(A)-1
    y=x+1;
    X=A(x);
    Y=A(y);
    x_ind=find(f==X);
    y_ind=find(f==Y);
    liklihood=log(liklihood*P(x_ind,y_ind));
end
L2=liklihood;

acc=min(L2/L1,1);          % acceptance probability
z=rand;                         % get uniform RV
if z<acc                        % if accept proposed flip
    f=fnew;    % flip spin
    acceptance=acceptance+1;
end
end