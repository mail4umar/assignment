% X=A(1:25);
% Y=A(2:26);
digits(40)

X=A(1:end-1);
Y=A(2:end);
[~,x_ind]=ismember(X,C);
[~,y_ind]=ismember(Y,C);
sz = size(P);
ind = sub2ind(sz,x_ind,y_ind);
liklihood=sum(log(P(ind)))
% prod(log(P(ind)))
% log(prod(P(ind)))
% exp(log(prod(P(ind))))


liklihood=0;
ls=[];
for x=1:length(A)-1
    y=x+1;
    X=A(x);
    Y=A(y);
    x_ind=find(C==X);
    y_ind=find(C==Y);
    liklihood=liklihood+log((P(x_ind,y_ind)));
end
L_loop=(liklihood)



% q=log(P(ind));
% w=find(q==0)
% P(ind(w))
% [xx yy] = ind2sub(sz,ind(w));