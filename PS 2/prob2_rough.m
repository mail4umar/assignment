nu=1.5;
N=100;
iqra=[];
for M=[1e2,1e3,1e4,1e5,1e6]
[IQR] = lastname_firstname_hw2_prob2(N,M,nu);
iqra=cat(1,iqra,IQR);
end

rates=[];
for i=1:length(iqra)-1
   rate=iqra(i)/iqra(i+1);
   rates=[rates;rate];
end
mean(rates)
