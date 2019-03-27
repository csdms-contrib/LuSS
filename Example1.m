%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   EXAMPLE HISTORY #1: Quartz grain wandering through a landscape
%
%   Author: Nathan Brown, nathan.brown <at> berkeley.edu Date: March 18, 2019
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Create a sample
sample=struct;%a data structure

%%  Assign luminescence characteristics, grouped for feldspar or quartz
[sample]=makeSampleQuartz(sample);

%%  Choose to empty traps to begin with. This sample is starts within old, cold bedrock, so traps begin full.
[sample]=fillTraps(sample);

%%  Begin with grain inside bedrock, just to show how traps begin full before grain is brought to surface
T=10;%deg.C
t=3;%ka
[sample,nN_t_1,tArray_1]=darkHeatExposure(sample,t,T);%time (ka), initial and final temperatures (deg.C),

%%  Plot
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h1=nN_t_plot(tArray_1,nN_t_1,logTyes);%plot your results
ylim([-0.1 1.1])%to easily compare saturation between events, establish a consistent y-axis range

%%  Erode out to sit on ground surface for 1 min
expTime=60/(3600*24*365.25*1e3);%ka
expTemp=10;
[sample,nN_t_2,tArray_2]=sunlightExposure(sample,expTime,expTemp);%time (ka) and temperature (deg.C)

%%  Plot
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h2=nN_t_plot(tArray_2,nN_t_2,logTyes);
ylim([-0.1 1.1])

%%  Progressively bury by 10 cm of "rock" over 20 ka (rock is here a proxy for sediment, 
%       though in reality rock would of course be more opaque).
%   NOTE:   For this step, we directly use the 'rateEqn.m' function. Normally this is called within the 
%   parent fxns (e.g., darkHeatExposure, sunlightExposure), but, as we do here, it can be called directly
%   for more flexibility.
expTime=20;
mu_W=-99;%not used, but must be passed
waterDepth=0;%mm, no water over grain
rockDepths=[0,100,1];%bury from 0 to 100 mm in at a linear rate, i.e., k=1 and d_R(t) = (t/tF)^k * (d_R_F - d_R_0) + d_R_0
[sample,nN_t_3,tArray_3]=rateEqn(sample,expTime,expTemp,mu_W,waterDepth,rockDepths);

%%  Plot
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h3=nN_t_plot(tArray_3,nN_t_3,logTyes);
ylim([-0.1 1.1])

%%  Wash out into stream during a 1-day storm, covered by 0.2 m of water for 12 hr of sunlight exposure
expTime=12/(24*365.25*1e3);%12 hours as kyr
waterDepth=200;%mm, water overburden
[sample,nN_t_4,tArray_4]=underwaterSunlightExposure(sample,expTime,expTemp,waterDepth);%time (ka), temperature (deg.C), depth (mm)

%%  Plot
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h4=nN_t_plot(tArray_4,nN_t_4,logTyes);
ylim([-0.1 1.1])

%%  Rebury sediment for another 30 ka
expTime=30;
[sample,nN_t_5,tArray_5]=darkHeatExposure(sample,expTime,expTemp);

%%  Plot
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h5=nN_t_plot(tArray_5,nN_t_5,logTyes);
ylim([-0.1 1.1])

%%  Wildfire exposure, reach peak heat of 500C superlinearly (k=2) over 2 hrs
expTime=2/(24*365.25*1e3);%2 hrs, as kyr
rampUpTemps=[10,500,2];%10 C to 500C, k=2
mu_W=-99;%not used, but must be passed
waterDepth=0;%mm, no water over grain
rockDepth=50;%5 cm overburden
[sample,nN_t_6,tArray_6]=rateEqn(sample,expTime,rampUpTemps,mu_W,waterDepth,rockDepth);

%%  Plot
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h6=nN_t_plot(tArray_6,nN_t_6,logTyes);
ylim([-0.1 1.1])

%%  Rebury sediment for another 5 ka
expTime=5;
[sample,nN_t_7,tArray_7]=darkHeatExposure(sample,expTime,expTemp);

%%  Plot
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h8=nN_t_plot(tArray_7,nN_t_7,logTyes);
ylim([-0.1 1.1])
