L=50;       % side of the square grid
H=0;        % external field strength (also try 0.1)
J=1;        % coupling strength (keep=1)
T=2.2692;   % temperature.   This is critical value; try higher or lower

nits=20000; % number of iterations (so it doesn't run forever)
    
npass=1.0;  % take = 1 to see every iteration
npass=L^2;  % L^2 iterations for display shows more rapid progress

esave=zeros(nits,1);    % vector to save energies

spins=2*(rand(L)>0.5)-ones(L);      % random initial condition
totspin=sum(sum(spins));            % total spin
mag=totspin/L^2;                    % magnetization

shiftdn=[2:L 1];                    % shifted indices for calculation
shiftup=[L 1:(L-1)];                % assumes periodic boundary conditions

% calculate initial energy and save
%
energy=-H*totspin-(J/2)*sum(sum(spins.*(spins(1:L,shiftdn)+spins(1:L,shiftup)+spins(shiftdn,1:L)+spins(shiftup,1:L))));
esave(1)=energy;

% uncomment block below to have a burn-in period

% for jj=1:50
%     %for jj=1:1
%     
%     %for k=1:1
%     for kk=1:L^2
%         
%         ipos=floor((L-eps)*rand)+1;
%         jpos=floor((L-eps)*rand)+1;
%         
%         up=mod(ipos+1-1,L)+1;
%         dn=mod(ipos-1-1,L)+1;
%         lf=mod(jpos-1-1,L)+1;
%         rt=mod(jpos+1-1,L)+1;
%         
%         du=2*spins(ipos,jpos)*(H+J*(spins(up,jpos)+spins(dn,jpos)+spins(ipos,lf)+spins(ipos,rt)));
%         acc=min(exp(-du/T),1);
%         z=rand;
%         if z<acc
%             %%          fprintf(1,'flip %i,%i\n',ipos,jpos);
%             spins(ipos,jpos)=(-1)*spins(ipos,jpos);
%             energy=energy+du;
%             mag=mag+2*H*spins(ipos,jpos)/L^2;
%         end
%         
%     end
%     
% end


count=1;

for jj=1:nits
    
    for kk=1:npass
        
        %
        % find a random position
        %
        ipos=floor((L-eps)*rand)+1;
        jpos=floor((L-eps)*rand)+1;
        
        up=mod(ipos+1-1,L)+1;   % "up" direction --- with periodic bcs
        dn=mod(ipos-1-1,L)+1;   % down
        lf=mod(jpos-1-1,L)+1;   % left
        rt=mod(jpos+1-1,L)+1;   % right
        
        %
        % calculate proposed change of energy
        %
        du=2*spins(ipos,jpos)*(H+J*(spins(up,jpos)+spins(dn,jpos)+spins(ipos,lf)+spins(ipos,rt)));
        acc=min(exp(-du/T),1);          % acceptance probability
        z=rand;                         % get uniform RV
        if z<acc                        % if accept proposed flip
            %%          fprintf(1,'flip %i,%i\n',ipos,jpos);
            spins(ipos,jpos)=(-1)*spins(ipos,jpos);     % flip spin
            energy=energy+du;                           % update energy  
            mag=mag+2*H*spins(ipos,jpos)/L^2;           % update magnetization
        end
    end
    
    %
    % save energy
    %
    count=count+1;
    esave(count)=energy;
    
    %
    % plot spins
    %
    figure(1);
    pcolor(spins);
    caxis([-1 1]);
    colormap(gray);
    axis square;
    
    %
    % plot energy
    %
    figure(2);
    plot(esave(1:count),'linewidth',2);
    
    drawnow;
    
end