for attempts=1:1
for trials= [1e4]
   z=2*rand(trials,1);
   y=2*z.^3;
   mean(y);
   vr=sqrt(var(y)/trials);
   fprintf(1,'mean %6.4f\nvariance %6.4f \n' ,mean(y),vr)
%     fprintf(1,'var',mean(y))
end
end