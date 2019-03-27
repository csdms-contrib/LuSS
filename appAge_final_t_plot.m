function [handle]=appAge_final_t_plot(sampleIn,nN_t_d)
% plots apparent age as a function of depth at the final time
%
%   INPUTS: 
%       sampleIn: sample structure 
%       nN_t_d: matrix of n/N values Column per depth (mm), row per timestep (ka)
%
%   OUTPUT:
%       Returns figure handle

handle=figure;
appAgeFinal=-(sampleIn.D0/sampleIn.Ddot)*log(1-nN_t_d(end,:)');

    if length(sampleIn.nN)==1
        disp('Grain, not cobble. This function is not useful.')
        close(handle)
    else
        depthArray=sampleIn.nN(:,1);
        plot(appAgeFinal,depthArray/10)
        
        ylabel('Cobble depth (cm)');
        xlabel('Apparent age (ka)')
         
        set(gca,'Ydir','reverse')

    end
end