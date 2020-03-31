function [sampleOut,tarray,Tmat] = heatDiffusion1D(sampleIn,duration,Trock,Theatbath)
%   (3/27/2020)
%   transient head conduction in 1-D sphere with internal heat gradient 
%       (appropriate when thermally thick; biot number > 0.1)

% INPUTS
%   sampleIn -- sample structure
%   duration -- ka, the total time of simulation
%   Trock -- deg.C, starting internal temperature of the rock; only single value is possible
%   Theatbath -- deg.C, temperature of 'infinite heat bath', e.g., air
%      temperature during wildfire
%
% OUTPUTS
%   sampleOut -- This structure will contain the updated 'internalTarray' field
%   tArray -- Every timestep with a T(d,t) solution, ka
%   TmatDimensional -- T(d,t) in deg C

%% read in sample structure
    sampleOut=sampleIn;
    dArray=sampleOut.nN(:,1);%depths, mm
    
    %note that, by frame of reference, r=r0 is surface, r=0 is center
    r0=dArray(end);
    rStarArray=dArray./r0;
    
    % time, ka
    numtstep=500;
    tarray=(duration/numtstep):(duration/numtstep):duration;
    
    %% thermal properties
    % typical values for granite
    Km2s=1.6e-6;%thermal diffusivity, m^2/s
    K=Km2s*1e6*(3600*24*365.25*1e3);%mm^2/ka
    kappaWmK=2;%W/(m*K)
    kappa=kappaWmK/1e3;%W/(mm*K)
    % taken from Butler (2010), based on heating of sensors during wildland
    %   fire experiment
    hcWm2K=50;%convective heat transfer coefficient, W/(m^2*K)
    hc=hcWm2K/1e6;%W/(mm^2*K)
                    
    % Fourier number
    Fo=(K*duration)./r0^2;
    disp('Fourier number: ')
    disp(Fo)
    
    %% calculate roots
    % Biot number (dimensionless); thermally 'thin' when Bi < 0.1; 
    %   small values indicate that heat transport is limited by convection at the surface, not conduction within the interior
    Bi=(hc/kappa)*r0;
    disp('Biot number: ')
    disp(Bi)
    %calculate roots
    zetaMax=500;%find roots of Bi = 1 - zeta*cot(zeta) from zeta = 0 to zetaMax
    zArray=zRoots(Bi,zetaMax);

    %% calculate thetaStar
    thetaStarMat=zeros(length(rStarArray),length(tarray));

    wb=waitbar(0,'iterating through T(r,t)');
    for k=1:length(rStarArray)
        waitbar(k/length(rStarArray))
        rStar_k=rStarArray(k);

        for j=1:length(tarray)
            t_j=tarray(j);

            % Fourier number
            Fo=(K*t_j)./r0^2;% Fourier number array (dimensionless); small values indicate that heat does not have sufficient time to equilibrate by diffusion for supplied time value
            %calculate thetaStar array
            thetaStarArray=zeros(size(zArray));
            for i=1:length(zArray)
                z_i=zArray(i);

                numer=4*(sin(z_i)-z_i*cos(z_i));
                denom=2*z_i-sin(2*z_i);
                Cn_i=numer/denom;

                thetaStarArray(i)=Cn_i.*exp(-z_i^2*Fo).*(1/(z_i*rStar_k)).*sin(z_i*rStar_k);
            end
            thetaStar=sum(thetaStarArray);
            thetaStarMat(k,j)=thetaStar;
        end
    end
    close(wb)

    %% convert thetaStar(rStar,t) into T(rStar,t)
    Tmat=Theatbath+(Trock-Theatbath)*thetaStarMat;
    
    %% flip T(d,t) matrix vertically to get correct frame of reference
    Tmat(1,:)=Tmat(2,:);%lazy temporary fix
    Tmat=flipud(Tmat);
    
    %% plot T(d,t)
    figure
    surf(tarray*1e3*365.25*24*60,dArray/10,Tmat);
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
    plot(tarray*1e3*365.25*24*60,Tmat(1,:)');
    hold on
    plot(tarray*1e3*365.25*24*60,Tmat(end,:)');
    hold off
    xlabel('Time (min)')
    ylabel('Temperature (deg.C)')
    

end
