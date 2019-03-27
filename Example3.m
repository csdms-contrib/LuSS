%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   EXAMPLE HISTORY #3: Feldspar within cobble exposed to wildfire
%
%   Author: Nathan Brown, nathan.brown <at> berkeley.edu Date: March 25, 2019
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Create a sample
sample=struct;%a data structure

%%  Assign luminescence characteristics, grouped for feldspar or quartz
[sample]=makeSampleFeldspar(sample);

%%  Choose to fill traps initially.
[sample]=fillTraps(sample);

%%  Define sample as a cobble of radius 10 cm. Monitor n/N evolution at 1 mm spacing. r d=0:spacing:radius
[sample]=makeSampleCobble(sample,100,1);

%%  Wildfire exposure, reach peak heat of 400C superlinearly (k=2) over 2 hrs
expTime=2/(24*365.25*1e3);%2 hrs, as kyr
rampUpTemps=[10,400,2];%10 C to 400C, k=2
mu_W=-99;%not used, but must be passed
waterDepth=0;%mm, no water over grain
rockDepth=100;%100 cm overburden; arbitrary -- prevents sunlight bleachign
[sample,nN_t_d_1,tArray_1]=rateEqn(sample,expTime,rampUpTemps,mu_W,waterDepth,rockDepth);

%%  Plots
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h1=nN_t_d_3dplot(sample,tArray_1*1e3*365.25*24*60,nN_t_d_1,logTyes);
caxis([0 1])
xlabel('Time (min)')

h2=nN_final_t_plot(sample,nN_t_d_1);

%%  Wildfire exposure, cool from peak heat of 400C sublinearly (k=0.5) over 2 hrs
expTime=2/(24*365.25*1e3);%2 hrs, as kyr
rampUpTemps=[400,10,0.5];%10 C to 400C, k=0.5
mu_W=-99;%not used, but must be passed
waterDepth=0;%mm, no water over grain
rockDepth=100;%100 cm overburden; arbitrary -- prevents sunlight bleachign
[sample,nN_t_d_2,tArray_2]=rateEqn(sample,expTime,rampUpTemps,mu_W,waterDepth,rockDepth);

%%  Plots
logTyes=0;%value of 1 forces time axis to logarithmic scale when plotting. 0 for linear scale
h3=nN_t_d_3dplot(sample,tArray_2*1e3*365.25*24*60,nN_t_d_2,logTyes);
caxis([0 1])
xlabel('Time (min)')

h4=nN_final_t_plot(sample,nN_t_d_2);
xlim([0 1])
