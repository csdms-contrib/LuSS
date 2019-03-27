function [sampleOut,nN_t_d,tArray] = underwaterSunlightExposure(sampleIn,exposureTime,exposureTemperature,waterDepth)
% exposes sample to subaqueous sunlight for some amount of exposure time (ka) at a specified
% ambient temperature (deg.C), e.g., the local atmospheric temperature
%
%   INPUTS:
%       sampleIn: a structure containing sample characteristics
%       exposureTime: in ka
%       exposureTemperature: in C (can be value or array of 3, as described in 'rateEqn.m')
%       waterDepth: in mm
%
%   OUTPUTS:
%       sampleOut: a structure containing sample characteristics after experiencing the environmental history
%       nN_t_d: one column per depth, one row per timestep; if a grain, only one column
%       tArray: one column with each entry a timestep (ka)

mu_W=0.034;%attenuation coefficient for water, mm^-1; from Harrison Gray, e.g., Gray et al. (2018) GRL, SM
d_W=waterDepth;
d_R=0;%no overburden rock (cobble thickness still considered, if applicable)

[sampleOut,nN_t_d,tArray] = rateEqn(sampleIn,exposureTime,exposureTemperature,mu_W,d_W,d_R);

end
