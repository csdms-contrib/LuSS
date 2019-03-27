function [handle]=appAge_t_d_3dplot(sampleIn,tArray,nN_t_d,logT)
% plots 3D surface of apparent age as a function of time and cobble depth
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
appAgeMat=-(sampleIn.D0/sampleIn.Ddot)*log(1-nN_t_d');

    if length(sampleIn.nN)==1
        disp('Grain, not cobble. Use nN_t_plot() instead.')
        close(handle)
    else
        depthArray=sampleIn.nN(:,1);
        surf(tArray,depthArray/10,appAgeMat)
        
        xlabel('Time (ka)');
        ylabel('Cobble depth (cm)');
        zlabel('Apparent age (ka)')
        
        set(gca,'Ydir','reverse')
        
        colormap(flipud(hot))
        c=colorbar;
        c.Label.String='Apparent age (ka)';
        shading interp
        view(2)
        
        if logT==1
            set(gca,'xscale','log')
        else
            %nothing
        end
    end
end