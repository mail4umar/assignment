% X=A(1:25);
% Y=A(2:26);
digits(40)

X=A(1:end-1);
Y=A(2:end);
[~,x_ind]=ismember(X,C);
[~,y_ind]=ismember(Y,C);
sz = size(P);
ind1 = sub2ind(sz,x_ind,y_ind);
% ind = sub2ind(sz,x_ind,y_ind);
LL1=sum(log(P(ind1)))


X=A(1:end-1);
Y=A(2:end);
[~,x_ind]=ismember(X,fnew);
[~,y_ind]=ismember(Y,fnew);
sz = size(P);
ind2 = sub2ind(sz,x_ind,y_ind);
% ind = sub2ind(sz,x_ind,y_ind);
LL2=sum(log(P(ind2)))

ratio=exp(LL2-LL1)
ratio2=exp(sum(log(P(ind2)))-sum(log(P(ind1))))
% ratio3=prod(P(ind2))/prod(P(ind1))
ratio4=exp(log(prod(P(ind2)))-log(prod(P(ind1))))


% liklihood=0;
% ls=[];
% for x=1:length(A)-1
%     y=x+1;
%     X=A(x);
%     Y=A(y);
%     x_ind=find(C==X);
%     y_ind=find(C==Y);
%     liklihood=liklihood+log((P(x_ind,y_ind)));
% end
% L_loop=(liklihood)


