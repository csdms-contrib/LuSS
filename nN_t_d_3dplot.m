function [handle]=nN_t_d_3dplot(sampleIn,tArray,nN_t_d,logT)
% plots 3D surface of nN as a function of time and cobble depth
%
%   INPUTS: 
%       sampleIn: sample structure 
%       tArray: time column (ka), e.g., as returned by functions such as 'darkHeatExposure' or 'sunlightExposure'
%       nN_t_d: matrix of n/N values Column per depth (mm), row per timestep (ka)
%       logT: If 1, set time axis to log scale. If 0, linear scale
%
%   OUTPUT:
%       Returns figure handle

handle=figure;

    if length(sampleIn.nN)==1
        disp('Grain, not cobble. Use nN_t_plot() instead.')
        close(handle)
    else
        depthArray=sampleIn.nN(:,1);
        surf(tArray,depthArray/10,nN_t_d')
        
        xlabel('Time (ka)');
        ylabel('Cobble depth (cm)');
        zlabel('Fractional saturation, n/N')
        
        set(gca,'Ydir','reverse')
        
        colormap(flipud(hot))
        c=colorbar;
        c.Label.String='Fractional saturation (n/N)';
        shading interp
        view(2)
        
        if logT==1
            set(gca,'xscale','log')
        else
            %nothing
        end
    end
end