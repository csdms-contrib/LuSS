function [sampleOut,nN_t_d,tArray] = rateEqn(sampleIn,duration,T,mu_W,d_W,d_R)
% Luminescence rate equation
%
%   INPUTS:
%       sampleIn: a structure containing sample characteristics
%           NOTE 1: d_R is interpreted as rock thickness above grain or cobble; thickness of cobble is in addition to this.
%           NOTE 2: T, d_W and d_R can all be input as values or arrays of length 3. If the latter, interpreted as [initial,final,k] values, where
%               k defines whether change with time is linear (k=1), sublinear (k<1), or supralinear (k>1). In other words: T(t) = (t/tF)^k * (TF - T0) + T0
%
%   OUTPUTS:
%       sampleOut: a structure containing sample characteristics after experiencing the environmental history
%       nN_t_d: one column per depth, one row per timestep; if a grain, only one column
%       tArray: one column with each entry a timestep (ka)

sampleOut=sampleIn;

%read in all sample parameters
D0=sampleOut.D0;%Gy
Ddot=sampleOut.Ddot;%Gy/ka
s=sampleOut.s;%ka^-1
E=sampleOut.E;%eV
sP0=sampleOut.sigmaPhi0;%ka^-1
mu_R=sampleOut.mu_R;%mm^-1

kB=8.617e-5;%eV/K, Boltzmann constant

depth_nN=sampleOut.nN;

    %read in depths and fractional saturation values
    if length(depth_nN)>1
        depth=depth_nN(:,1);
        nN=depth_nN(:,2);
    else
        depth=0;
        nN=depth_nN;
    end
    
    %thermal diffusion timescale, t_D. Used to decide whether T(depth,t) needs to be
%   modelled or whether T(t) is a good approximation. The somewhat arbitrary 
%   cut-off I use is that if duration < 20*t_D, model T(depth,t), else model T(t) the same for every depth
kappa=1*3600*24*365.25*1e3;%mm^2/ka. 1 mm^2/s is a pretty standard value for granite
t_D=((max(depth)*2/2)^2)/kappa;%ka, diffusion timescale; depth is multiplied by 2 because radius
    
%%  if thermal diffusion into the rock is slow realtive to the duration and if cobble, not grain

    if duration < 20*t_D && length(depth)>1
        disp('Calculating T(d,t)...')
        %solve heat equation at all depths
        [sampleOut,heat_tArray,heat_Tmat]=heatDiffusion1D(sampleOut,duration,T);
        
        polyArray=cell(length(depth),1);
        %used to segment polynomial for fitting, increase for better resolution, slower solutions
        numBreaks=10;
        %for each depth, fit T(t) data with polynomial
        for i=1:length(depth)
            polyArray{i}=splinefit(heat_tArray,heat_Tmat(i,:),numBreaks);
        end
    else
        %if treatment is long, set internal temperature to prescribed (surficial) temperature at the final time step, i.e., rock is in thermal equilibrium
        % This line also creates the field if previously absent.
        sampleOut.internalTarray(1:length(depth))=val_from_t(duration,duration,T);
    end

    
%%
    %ODE to be called later
    function [dnN] = dnN(t,nNin)
        
        %if duration is shorter than diffusion timescale, supply T(d,t) to solver
        if duration < 20*t_D && length(depth)>1
            TK_t=zeros(length(depth),1);
            %for every timestep, must get T(t) at every depth from polynomial
            for j=1:length(depth)
                TK_t(j)=ppval(polyArray{j},t)+273.15;
            end
        %otherwise, supply T(t) to solver
        else
            TK_t=val_from_t(t,duration,T)+273.15;
        end
        
        dW_t=val_from_t(t,duration,d_W);
        dR_t=val_from_t(t,duration,d_R);
        
        gainTerm=(Ddot/D0).*(1-nNin);
        thermalLossTerm=nNin.*(s.*exp(-E./(kB.*TK_t)));
        opticalLossTerm=nNin.*(sP0*exp(-mu_R*(dR_t+depth)-mu_W*dW_t));
        
        dnN=gainTerm -thermalLossTerm - opticalLossTerm;
    end

%call ODE here            
disp('Calculating d/dt (n/N)...')
[tArray,nN_t_d]=ode23tb(@dnN,[0 duration],nN);

    %update fractional saturation values
    if length(depth_nN)>1
        sampleOut.nN(:,2)=nN_t_d(end,:)';
    else
        sampleOut.nN=nN_t_d(end);
    end
    
end

