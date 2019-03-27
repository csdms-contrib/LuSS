function [handle]=nN_t_plot(tArray,nN_t_d,logT)
% plots nN as a function of time
%
%   INPUTS: 
%       tArray: time column (ka), e.g., as returned by functions such as 'darkHeatExposure' or 'sunlightExposure'
%       nN_t_d: matrix of n/N values Column per depth (mm), row per timestep (ka)
%       logT: If 1, set time axis to log scale. If 0, linear scale
%
%   OUTPUT:
%       Returns figure handle

handle=figure;

    if size(nN_t_d,2)>1
        disp('Cobble, not grain. Use nN_t_d_3dplot() instead.')
        close(handle)
    else
        plot(tArray,nN_t_d)
        
        xlabel('Time (ka)');
        ylabel('Fractional saturation, n/N')
        
        if logT==1
            set(gca,'xscale','log')
        else
            %nothing
        end
    end
end