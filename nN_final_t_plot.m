function [handle]=nN_final_t_plot(sampleIn,nN_t_d)
% plots n/N as a function of depth at the final time
%
%   INPUTS: 
%       sampleIn: sample structure 
%       nN_t_d: matrix of n/N values Column per depth (mm), row per timestep (ka)
%
%   OUTPUT:
%       Returns figure handle

handle=figure;

    if length(sampleIn.nN)==1
        disp('Grain, not cobble. This function is not useful.')
        close(handle)
    else
        depthArray=sampleIn.nN(:,1);
        plot(nN_t_d(end,:)',depthArray/10)
        
        ylabel('Cobble depth (cm)');
        xlabel('Fractional saturation, n/N')
         
        set(gca,'Ydir','reverse')

    end
end