

lambda=10;
mu=0.05;
alpha=0.1; %0.1
beta=0.5;
num_ensemble=100;
t_final=2e2*5*10;

[probs]=lastname_firstname_hw3_prob2(alpha,beta,lambda,mu,num_ensemble,t_final);

binvals=[0:length(probs)-1]';
dist_params = fitdist(binvals, 'NegativeBinomial', 'frequency',floor(1e6*probs+0.5));
nbin_vals = pdf('NegativeBinomial',binvals,dist_params.Params(1), dist_params.Params(2));

plot(nbin_vals);hold on;plot(probs)