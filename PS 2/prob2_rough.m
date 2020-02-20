nu=1.5;
N=100;
iqra=[];
for M=[1e2,1e3,1e4,1e5,1e6]
[IQR] = lastname_firstname_hw2_prob2(N,M,nu);
iqra=cat(1,iqra,IQR);
end

plot(log10([1e2,1e3,1e4,1e5,1e6]),iqra);hold on
p=polyfit(log10([1e2,1e3,1e4,1e5,1e6]'),iqra, 1);
m=p(1)
c=p(2)
x=2:6;
plot(x,(m.*x+c))

%m=-0.1518

