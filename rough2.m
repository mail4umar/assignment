fprintf(1,'\nExact answer is sqrt(pi)*exp(-0.25) = %g\n\n',sqrt(pi)*exp(-0.25));
for trials=[100,1000,10000,100000,1000000]
z=randn(trials,1);
y=sqrt(pi)*cos(z/sqrt(2));
fprintf(1,'For %7i trials, mean is %6.4f and std error of the mean is %6.4f\n',trials,mean(y),sqrt(var(y)/trials));
end
fprintf(1,'\n');