# Luminescence Sample Simulator: 
A set of MATLAB functions to model how luminescence evolves in different geomorphic scenarios. Specifically, exposures to heat and sunlight can be simulated and the resulting signals shown. For a detailed description of the underlying luminescence rate equations, or to cite your use of **LuSS**, please use [Brown, (2020)](#B2020).

# Table of Contents
1. [Three worked examples](#three-examples)
2. [Functions to manipulate a sample](#manip-fxns)
	1. [Functions to initiate a sample](#init-fxns)
	2. [Functions to expose a sample to the environment](#expose-fxns)
3. [Functions to plot a sample's luminescence signal](#plot-fxns)
4. [Other functions](#other-fxns)
5. [Reference](#Reference)

# Three worked examples <a name="three-examples"></a>
Three worked examples are included to illustrate function usage. `Example1.m`  simulates a quartz grain wandering across a landscape, experiencing sunlight, wildfire heat, burial, and stream residence. `Example2.m` simulates a feldspar grain within a cobble that exhumes and is exposed to sunlight, first on the ground surface and then beneath water. `Example3.m` simulates a rock exposed to wildfire heat.

# Functions to manipulate a sample <a name="manip-fxns"></a>
After creating a sample as a data structure:

```matlab
	sample=struct;
```
the functions listed below manipulate that sample.

## Functions to initiate a sample <a name="init-fxns"></a>
Function | Usage
------------ | -------------
`makeSampleQuartz.m` | Assign luminescence characteristics of quartz to sample.
`makeSampleFeldspar.m` | Assign luminescence characteristics of K-feldspar to sample.
`makeSampleCobble.m` | Adds depth to a sample. By default, a sample is defined as a grain, for which inward diffusion of light and heat is neglected.
`makeCobbleIntoGrain.m` | Removes depth from a sample. The luminescence signal from the outermost cobble shell is assigned to the grain.
`fillTraps.m` | Sets the fractional saturation (*n/N*) of the sample's luminescence signal to one. For cobbles, this applies to all depths.
`emptyTraps.m` | Sets the fractional saturation (*n/N*) to zero. 

## Functions to expose a sample to the environment <a name="expose-fxns"></a>
Function | Usage
------------ | -------------
`sunlightExposure.m` | Expose a cobble or grain to sunlight.
`underwaterSunlightExposure.m` | Expose a cobble or grain to sunlight attenuated by water.
`darkGrainHeatExposure.m` | Expose a grain to heat but not sunlight.
`rateEqn.m` | Expose a cobble or grain to heat or sunlight (with or without rock or water attenuation). This function is called by the previous three functions.


# Functions to plot a sample's luminescence signal <a name="plot-fxns"></a>
Function | Usage
------------ | -------------
`nN_t_plot.m` | Plots fractional saturation (*n/N*) as a function of time. Use for grains.
`nN_t_d_3dplot.m` | Plots fractional saturation (*n/N*) as a function of time and cobble depth. Use for cobbles.
`nN_final_t_plot.m` | Plots fractional saturation (*n/N*) as a function of cobble depth at the final timestep. Use for cobbles.
`appAge_t_plot.m` | Plots apparent age (ka) as a function of time. Use for grains.
`appAge_t_d_3dplot.m` | Plots apparent age (ka) as a function of time and cobble depth. Use for cobbles.
`appAge_final_t_plot.m` | Plots apparent age (ka) as a function of cobble depth at the final timestep. Use for cobbles.

# Other functions <a name="other-fxns"></a>
All other functions included in the repository are dependencies that should be kept in the same directory as the other files, but will not ordinarily be directly used. 

`splinefit.m` is copyright 2009, Jonas Lundgren. All rights reserved. Retrieved from [MATLAB Central File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/71225-splinefit) in 2019.

`zroots.m` is modified from:
Recktenwald, G., 2006. [Transient, one-dimensional heat conduction in a convectively cooled sphere](http://www.webcitation.org/60nDyv3Yy), Portland State University, Dept. of MME.
# Reference
<a id="B2020">[Brown, N.D., 2020.]</a> Which geomorphic processes can be informed by luminescence measurements? *in press at Geomorphology*.
