function [handle]=appAge_t_plot(sampleIn,tArray,nN_t,logT)
% plots apparent age of grain as a function of time
%
%   INPUTS: 
%       sampleIn: sample structure 
%       tArray: time column (ka), e.g., as returned by functions such as 'darkHeatExposure' or 'sunlightExposure'
%       nN_t: array of n/N values per timestep (ka)
%       logT: If 1, set time axis to log scale. If 0, linear scale
%
%   OUTPUT:
%       Returns figure handle

handle=figure;
appAgeArray=-(sampleIn.D0/sampleIn.Ddot)*log(1-nN_t);

    if size(nN_t,2)>1
        disp('Cobble, not grain. Use appAge_t_d_3dplot() instead.')
        close(handle)
    else
        plot(tArray,appAgeArray)
        
        xlabel('Time (ka)');
        ylabel('Apparent age (ka)')
        
        if logT==1
            set(gca,'xscale','log')
        else
            %nothing
        end
    end
end