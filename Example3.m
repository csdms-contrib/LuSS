%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   EXAMPLE HISTORY #3: Feldspar within cobble exposed to wildfire
%
%   Author: Nathan Brown, nathan.brown <at> berkeley.edu Date: March 30, 2020
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Create a sample
sample=struct;%a data structure

%%  Assign luminescence characteristics, grouped for feldspar or quartz
[sample]=makeSampleFeldspar(sample);

%%  Choose to fill traps initially.
[sample]=fillTraps(sample);

%%  Define sample as a cobble of radius 10 cm. Monitor n/N evolution at 1 mm spacing. d=0:spacing:radius
[sample]=makeSampleCobble(sample,80,1);

%%  Wildfire exposure
expTime=20/(60*24*365.25*1e3);%20 m, as kyr
fireTemp=400;%400C
mu_W=-99;%not used, but must be passed
waterDepth=0;%mm, no water over grain
rockDepth=100;%1000 mm overburden; imitating cover by 'debris' to prevent light bleaching prior to fire
[sample,nN_t_d_1,tArray_1]=rateEqn(sample,expTime,fireTemp,mu_W,waterDepth,rockDepth);

%%  Plots
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h1=nN_t_d_3dplot(sample,tArray_1*1e3*365.25*24*60,nN_t_d_1,logTyes);
caxis([0 1])
xlabel('Time (min)')

h2=nN_final_t_plot(sample,nN_t_d_1);
