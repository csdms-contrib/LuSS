%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   EXAMPLE HISTORY #2: Feldspar within detrital cobble eroding from an active orogen
%
%   Author: Nathan Brown, nathan.brown <at> berkeley.edu Date: March 18, 2019
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Create a sample
sample=struct;%a data structure

%%  Assign luminescence characteristics, grouped for feldspar or quartz
[sample]=makeSampleFeldspar(sample);

%%  Choose to empty traps to begin with. As this sample is uplifting from a temperature of 110C, this is sensible.
[sample]=emptyTraps(sample);

%%  Define sample as a cobble of radius 3 cm. Monitor n/N evolution at 0.1 mm spacing. r d=0:spacing:radius
[sample]=makeSampleCobble(sample,30,0.1);

%%  Cool from 110 to 10 deg.C over 1 Ma (dT/dt = -1000C/Ma)
T0=110;%deg.C, initial temperature
TF=10;%deg.C, final temperature
t=100;%ka
linearity=1;%1 for linear temperature change, less than 1 for sublinear, greater than 1 for supralinear
[sample,nN_t_d_1,tArray_1]=darkHeatExposure(sample,t,T0,TF,linearity);%time (ka), initial and final temperatures (deg.C),

%%  Plot
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h1=nN_t_d_3dplot(sample,tArray_1,nN_t_d_1,logTyes);%plot your results, for a cobble
caxis([0 1])%to easily compare saturation between events, establish a consistent colorbar scale

%%  Erode out to sit on ground surface for 1 ka
expTime=1;%ka
expTemp=10;
[sample,nN_t_d_2,tArray_2]=sunlightExposure(sample,expTime,expTemp);%time (ka) and temperature (deg.C)

%%  Plot
logTyes=1;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h2=nN_t_d_3dplot(sample,tArray_2,nN_t_d_2,logTyes);%plot your results, for a cobble
caxis([0 1])

%%  Flush down river to sit in stream for 50 ka, covered by 20 cm of water
expTime=50;%ka
waterDepth=200;%mm, water overburden
[sample,nN_t_d_3,tArray_3]=underwaterSunlightExposure(sample,expTime,expTemp,waterDepth);%time (ka), temperature (deg.C), depth (mm)

%%  Plot; final time step would be 'as collected'
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h3=nN_t_d_3dplot(sample,tArray_3,nN_t_d_3,logTyes);%plot your results, for a cobble
caxis([0 1])
