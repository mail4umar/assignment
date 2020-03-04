% X=A(1:25);
% Y=A(2:26);

X=A(1:end-1);
Y=A(2:end);
[~,x_ind]=ismember(X,C);
[~,y_ind]=ismember(Y,C);
sz = size(P);
ind = sub2ind(sz,x_ind,y_ind);
liklihood=prod(PP(ind))
prod(log(PP(ind)))
log(prod(PP(ind)))
exp(log(prod(PP(ind))))

% q=log(P(ind));
% w=find(q==0)
% P(ind(w))
% [xx yy] = ind2sub(sz,ind(w));