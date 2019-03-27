function [sampleOut,tArray,TmatDimensional] = heatDiffusion1D(sampleIn,duration,T)
% same approach as in Mitchell and Reiners (2003), Geology, SM. 
%	Thanks to Mark Harrison for his lecture notes, which helped in implementing this solution.

% INPUTS
%   sampleIn -- sample structure. The first time this 'heatDiffusion1D' fxn is called, the internal temperature structure field of the sample is created.
%               All subsequent times, the field is queried. This means that the internal temperature of the rock can be remembered, and the rock can be
%               repeatedly passed to this function, allowing, for example, for a ramp up, a hold temperature, and a ramp down.
%   duration -- ka, the total time of simulation
%   T -- deg.C, same format as in rest of library: if single value, constant; if 3 values, interpreted as [initial,final,k] values, where
%               k defines whether change with time is linear (k=1), sublinear (k<1), or supralinear (k>1). In other words: T(t) = (t/tF)^k * (TF - T0) + T0

%   NOTE:   If not previously defined, the internal temperature of the cobble is taken as the constant or initial temperature value. All subsequent times
%               that the function is called, the internal temperature is read from the sampleIn data structure. This means that you must ramp up to higher temperatures (at least the first time).
%               Long heats (i.e., duration > t_D) are remembered. So, for example, if you dose a sample for 1 Ma at 10C, that becomes the internal temperature at all depths. If 
%               the current fxn were called, this internal temperature would be adopted (not the constant or initial temperature value from 'T'). So, it is only if you created
%               a sample and then immediately heated the sample from 15C to 500C over 20s, that the internal temperature would be set to 15C.
%
% OUTPUTS
%   sampleOut -- This structure will contain the updated 'internalTarray' field
%   tArray -- Every timestep with a T(d,t) solution, ka
%   TmatDimensional -- T(d,t) in ka and deg C

%%
sampleOut=sampleIn;

        %while the cobble is normally a 'half cobble', i.e., modelled from the surface to the center,
        %   for our heat equation solution we need fixed boundary conditions, so we deal with a 'whole cobble' in
        %   only within this function before converting back to a half cobble
        dArrayHalf=sampleOut.nN(:,1);
        d_d=dArrayHalf(2)-dArrayHalf(1);
        diam=max(dArrayHalf)*2;
        
        dArrayFull=0:d_d:diam;
        
        %first, identify dt step size that is suited for explicit finite difference solution
        %   at this stage, I only include linearly spaced arrays. Logarhithmic spacing could improve 
        %   speed in cases of nonlinear T(t) functions
        
        kappa=1*3600*24*365.25*1e3;%mm^2/ka. 1 mm^2/s is a pretty standard value for granite
        dt=duration/1;%this never gets chosen; even if suitable, divided by 10 in first loop.
        r=99;
        while r >= 0.5%make sure step size is numerically stable
            d_tPrime=kappa*dt/(diam^2);
            d_dPrime=d_d/diam;
            r=d_tPrime/(d_dPrime^2);

            dt=dt/2;
        end

    % time, ka
    tArray=0:dt:duration;
       
    %if the internal temperature structure of the cobble is yet undefined
    if ~isfield(sampleOut,'internalTarray')
        %define as initial temperature
        sampleOut.internalTarray(1:length(dArrayHalf))=val_from_t(0,duration,T);
    end
    
    Tmat=ones(length(dArrayFull),length(tArray));
    Tmax=max(val_from_t(tArray,duration,T));
    
    %variable T boundary condition
    Tmat(1,:)=val_from_t(tArray,duration,T);
    Tmat(end,:)=Tmat(1,:);
    
    %intial condition for internal cobble temperatures, borrowed from 'sample' data structure
    Tmat(2:end-1,1)=[sampleOut.internalTarray(2:end) fliplr(sampleOut.internalTarray(2:end-1))]';
    
    %dimensionless
    tPrimeArray=(kappa*tArray)./(dArrayFull(end)^2);%dimensionless time array
    dPrimeArray=dArrayFull./dArrayFull(end);%dimensionless depth array
    TprimeMat=Tmat./Tmax;%dimensionless temperature array
    
   %% loop through matrix
    % for every time
    for t_i=1:length(tPrimeArray)-1
        %for every depth except surface
        for d_i=2:length(dPrimeArray)-1
            d_tPrime=tPrimeArray(t_i+1)-tPrimeArray(t_i);
            d_dPrime=dPrimeArray(d_i)-dPrimeArray(d_i-1);
            r=d_tPrime/(d_dPrime^2);
            TprimeMat(d_i,t_i+1)=TprimeMat(d_i,t_i) + r.*(TprimeMat(d_i-1,t_i) + TprimeMat(d_i + 1,t_i) - 2*TprimeMat(d_i,t_i));
        end
    end
    
    %update cobble's internal temperature structure, but first convert back into 
    %   'half-cobble'
    TmatDimensional=Tmax*TprimeMat(1:length(dArrayHalf),:);%in degC, the temperature at every d,t combination
    sampleOut.internalTarray(:)=TmatDimensional(:,end);
    
    %% plot T(d,t)
    figure
    surf(tArray*1e3*365.25*24*60,dArrayHalf/10,TprimeMat(1:length(dArrayHalf),:).*Tmax);
    xlabel('Time (min)')
    ylabel('Cobble depth (cm)')
    zlabel('Temperature (deg.C)')
    set(gca,'Ydir','reverse')
    
    colormap(flipud(hot))
    c=colorbar;
    c.Label.String='Temperature (deg.C)';
    shading interp
    view(2)
    
    % plot T_surf (t)
    figure
    plot(tArray*1e3*365.25*24*60,Tmat(1,:)');
    xlabel('Time (min)')
    ylabel('Temperature (deg.C)')
    
end
