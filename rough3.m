tol=0.01;
tolcount=0;
for attempts=1:100
for trials= [1.36e6]
   z=2*rand(trials,1);
   y=2*z.^3;
   mu=mean(y);
   vr=sqrt(var(y)/trials);
   
   if (abs(mu-4)>tol)
       fprintf(1,'mean %6.4f variance %6.4f IT IS BAD \n' ,mean(y),vr)
       tolcount=tolcount+1
   else
       fprintf(1,'mean %6.4f variance %6.4f \n' ,mean(y),vr)
   end
   
%     fprintf(1,'var',mean(y))
end
end