function [sampleOut,nN_t_d,tArray] = darkGrainHeatExposure(sampleIn,exposureTime,varargin)
% exposes grain to static or changing heat without sunlight.
%    
%   INPUTS:
%       sampleIn: a structure containing sample characteristics
%       exposureTime: in ka
%   
%   OPTION 1: CHANGING TEMPERATURE
%       DARKHEATEXPOSURE(SAMPLEIN,EXPOSURETIME,INITIALTEMPERATURE,FINALTEMPERATURE,LINEARITY)
%           initialTemperature, finalTemperature: in deg. C
%           linearity: 1 for linear change, <1 for sublinear, >1 for supralinear
%   OPTION 2: STATIC TEMPERATURE
%       DARKHEATEXPOSURE(SAMPLEIN,EXPOSURETIME,TEMPERATURE)
%           temperature: in deg. C
%
%   OUTPUTS:
%       sampleOut: a structure containing sample characteristics after experiencing the environmental history
%       nN_t_d: column vector with an entry per timestep
%       tArray: one column with each entry a timestep (ka)

mu_W=0.1;%attenuation coefficient for water, mm^-1
d_W=0;%no water covering
d_R=1e6;%'infinite' overburden rock (cobble thickness still considered, if applicable)

if length(varargin)==1
    exposureTemperature=varargin{1};
elseif length(varargin)==3
    initialTemperature=varargin{1};
    finalTemperature=varargin{2};
    linearity=varargin{3};
    if initialTemperature==finalTemperature
        exposureTemperature=initialTemperature;
    else
        exposureTemperature=[initialTemperature,finalTemperature,linearity];    
    end
elseif length(sampleOut.nN) > 1%or, if sample is a cobble, do nothing
    disp('Sample is a cobble. Doing nothing.')
    return
else
    disp('Length of varargin must be 1 or 3')
    return
end

[sampleOut,nN_t_d,tArray] = rateEqn(sampleIn,exposureTime,exposureTemperature,mu_W,d_W,d_R);

end
