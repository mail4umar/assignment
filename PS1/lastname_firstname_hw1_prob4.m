function [chi2pvals]=lastname_firstname_hw1_prob4(M,N,a,nbins)
chi2bins=-log(1-((0:nbins)/nbins))/a; % create bins using the Finv function
fail=0; % initialize fail count
chi2pvals=[];

% Run loop for M times
for i=1:M
x=rand(1,N); % Random vetor of length N
X=-log(1-x)/a;
obs=histcounts(X,chi2bins);
pd=makedist('Exponential','mu',a);
[H,P] = chi2gof(X,'CDF',pd,'edges',chi2bins);
fail=fail+H;
pass=M-fail;
chi2pvals=[chi2pvals P];
end
% pass=M-fail
% fail
% histogram(Pvals,20)

end
