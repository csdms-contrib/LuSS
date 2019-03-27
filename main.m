%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   MAIN
%
%   Author: Nathan Brown, nathan.brown <at> berkeley.edu Date: March 7, 2019
%
%   Default units used are: t in ka, T in C, dose in Gy, length in mm, energy in eV
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   STEP 1: CREATE A SAMPLE
%
%

%%  Create a sample
sample=struct;%a data structure

%%  Assign luminescence characteristics, grouped for feldspar or quartz
[sample]=makeSampleQuartz(sample);
%[sample]=makeSampleFeldspar(sample);

%%  Manually modify any characteristics here. 
%       Options include: D0, Ddot, s, E, sigmaPhi0, mu_R, or type (type being 'quartz' or 'feldspar')
%
%sample.D0=235;%Gy. This is an example of a modification

%%  Choose to empty or fill sample traps to begin with
%[sample]=emptyTraps(sample);
[sample]=fillTraps(sample);

%%  Optionally, define sample as a cobble (default is a grain, where bleaching differences
%       within the grain can be neglected)
%
%       If making sample into cobble, inputs fields are: sample, cobble radius (mm),
%       and spacing (mm). The n/N (or, theta) values will be monitored for d=0:spacing:radius
%
%       The n/N value at all depths will be taken from existing (single) value. 
%       If not prev assigned, defined as 1 (full) at all depths.
[sample]=makeSampleCobble(sample,50,2);

%%  The reverse is also possible--a grain can be 'eroded' off the top of a cobble with the
%   makeCobbleIntoGrain command, where the n/N value is taken from the uppermost depth-slice.
%
%[sample]=makeCobbleIntoGrain(sample);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   STEP 2: DESIGN A GEOLOGIC HISTORY FOR THE SAMPLE
%
%

%%  Cooling bedrock time period
T0=100;%deg.C, initial temperature
TF=10;%deg.C, final temperature
t=500;%ka
linearity=1;%1 for linear temperature change, less than 1 for sublinear, greater than 1 for supralinear
[sample,nN_t_d_1,tArray_1]=darkHeatExposure(sample,t,T0,TF,linearity);%time (ka), initial and final temperatures (deg.C). Alternately, a single value, T, can be input instead of T0, TF, and linearity

logTyes=1;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h=nN_t_d_3dplot(sample,tArray_1,nN_t_d_1,logTyes);%plot your results, for a cobble

%%  Full sunlight time period
%expTime=100/(3600*24*365.25*1e3);%100 s, converted to ka
expTime=25;%ka
expTemp=10;
[sample,nN_t_d_2,tArray_2]=sunlightExposure(sample,expTime,expTemp);%time (ka) and temperature (deg.C)

logTyes=1;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h=nN_t_d_3dplot(sample,tArray_2,nN_t_d_2,logTyes);%plot your results, for a cobble

%%  Underwater time period
expTime=100/(365.25*1e3);%1 day, converted to ka
waterDepth=5;%mm, water overburden
[sample,nN_t_d_3,tArray_3]=underwaterSunlightExposure(sample,expTime,expTemp,waterDepth);%time (ka), temperature (deg.C), depth (mm)

logTyes=1;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h=nN_t_d_3dplot(sample,tArray_3,nN_t_d_3,logTyes);%plot your results, for a cobble
