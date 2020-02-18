% function [prob_est,stderr_of_est]=lastname_firstname_hw1_prob3(M)
% [X,Y]=three_selec()
M=1e7;
X=floor(1000*randn(3,M));
Y=floor(1000*randn(3,M));
a=sqrt((X(1,:)-X(2,:)).^2+(Y(1,:)-Y(2,:)).^2); % 1 and 2
b=sqrt((X(1,:)-X(3,:)).^2+(Y(1,:)-Y(3,:)).^2); % 1 and 3
c=sqrt((X(2,:)-X(3,:)).^2+(Y(2,:)-Y(3,:)).^2); % 2 and 3
Angle=[acosd((b.^2+c.^2-a.^2)./(2.*b.*c));acosd((a.^2+c.^2-b.^2)./(2.*a.*c));acosd((b.^2+a.^2-c.^2)./(2.*b.*a))];
Angle(Angle<=90)=0;Angle(Angle>90)=1;
Angle( :, all( ~any( Angle ), 1 ) ) = [];
obtuse=size(Angle,2);
prob_est=obtuse/M
stderr_of_est=sqrt((1/(M*(M-1)))*(obtuse*(1-prob_est)^2+(M-obtuse)*prob_est^2))

% AnlgeA=acosd((b.^2+c.^2-a.^2)./(2.*b.*c))
% AnlgeB=acosd((a.^2+c.^2-b.^2)./(2.*a.*c))
% AnlgeC=acosd((b.^2+a.^2-c.^2)./(2.*b.*a))
% 
% A=[X(1,:);Y(1,:)]
% B=[X(2,:);Y(2,:)]
% C=[X(3,:);Y(3,:)]
% 
% AB=B-A
% AC=C-A 
% BC=C-B
% AB=[AB;zeros(1,M)]
% AC=[AC;zeros(1,M)]
% BC=[BC;zeros(1,M)]
% CB=-BC;
% ThetaInDegrees = atan2d(norm(cross(AB,AC)),dot(AB,AC))
% ThetaInDegrees = atan2d(norm(cross(AC,BC)),dot(AC,BC))
% ThetaInDegrees = atan2d(norm(cross(AB,CB)),dot(AB,CB))
% % end
% 
% % ThetaInDegrees = atan2d(norm(cross(u,v)),dot(u,v));
% % beta = acos( ( a^2 + b^2 - c^2 ) / (2ab) )
% % norm(x-y)
% %  X = [0,0;2,1];
% %  d = pdist(X,'euclidean')
% function [X,Y]=three_selec()
% X=1000*randn(3,1);
% Y=1000*randn(3,1);
% end