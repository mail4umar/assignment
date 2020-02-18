function [prob_est,stderr_of_est]=lastname_firstname_hw1_prob3(M)
X=floor(1000*randn(3,M)); % 3 x M matrix
Y=floor(1000*randn(3,M));
a=sqrt((X(1,:)-X(2,:)).^2+(Y(1,:)-Y(2,:)).^2); % length between points 1 and 2
b=sqrt((X(1,:)-X(3,:)).^2+(Y(1,:)-Y(3,:)).^2); % length between points 1 and 3
c=sqrt((X(2,:)-X(3,:)).^2+(Y(2,:)-Y(3,:)).^2); % length between points 2 and 3

% Calculate the angles from lengths a,b and c
Angle=[acosd((b.^2+c.^2-a.^2)./(2.*b.*c));acosd((a.^2+c.^2-b.^2)./(2.*a.*c));acosd((b.^2+a.^2-c.^2)./(2.*b.*a))];
Angle(Angle<=90)=0;Angle(Angle>90)=1; %Put 1 where the angle is greater than 90
Angle( :, all( ~any( Angle ), 1 ) ) = []; %get rid of those columns with all 0s
obtuse=size(Angle,2); %number of columns=number of obtuse triangles
prob_est=obtuse/M;
stderr_of_est=sqrt((1/(M*(M-1)))*(obtuse*(1-prob_est)^2+(M-obtuse)*prob_est^2));
end