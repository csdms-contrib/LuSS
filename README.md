# Luminescence Sample Simulator: 
## MATLAB functions described in [Brown, (2020)](#B2020)
A set of MATLAB functions to model how luminescence evolves in different geomorphic scenarios. Specifically, exposures to heat and sunlight can be simulated and the resulting signals shown. For a detailed description of the underlying luminescence rate equations, or to cite your use of these **LuSS** functions, please use [Brown, (2020)](#B2020).

## GUI described in [Brown, (2025)](#B2025)
A graphical user interface (GUI) that incorporates some of the functions in [Brown, (2020)](#B2020), as well as some additional features, such as simulating the history of multiple grains. For a full description of this GUI, or to cite your usage, please use [Brown, (2025)](#B2025).

# Table of Contents
1. [MATLAB functions](#MATLAB-fxns)
	1. [Three worked examples](#three-examples)
	2. [Functions to manipulate a sample](#manip-fxns)
		1. [Functions to initiate a sample](#init-fxns)
		2. [Functions to expose a sample to the environment](#expose-fxns)
	3. [Functions to plot a sample's luminescence signal](#plot-fxns)
	4. [Other functions](#other-fxns)
2. [*LuSS* GUI](#LuSS-GUI)
	1. [Installing *LuSS* GUI as MATLAB toolbox](#install-toolbox)
	2. [Installing *LuSS* GUI as standalone application](#install-standalone)
	3. [GUI description](#GUI-description)
3. [Reference](#Reference)

# MATLAB functions <a name="MATLAB-fxns"></a>

## Three worked examples <a name="three-examples"></a>
Three worked examples are included to illustrate function usage. `Example1.m`  simulates a quartz grain wandering across a landscape, experiencing sunlight, wildfire heat, burial, and stream residence. `Example2.m` simulates a feldspar grain within a cobble that exhumes and is exposed to sunlight, first on the ground surface and then beneath water. `Example3.m` simulates a rock exposed to wildfire heat.

## Functions to manipulate a sample <a name="manip-fxns"></a>
After creating a sample as a data structure:

```matlab
	sample=struct;
```
the functions listed below manipulate that sample.

### Functions to initiate a sample <a name="init-fxns"></a>
Function | Usage
------------ | -------------
`makeSampleQuartz.m` | Assign luminescence characteristics of quartz to sample.
`makeSampleFeldspar.m` | Assign luminescence characteristics of K-feldspar to sample.
`makeSampleCobble.m` | Adds depth to a sample. By default, a sample is defined as a grain, for which inward diffusion of light and heat is neglected.
`makeCobbleIntoGrain.m` | Removes depth from a sample. The luminescence signal from the outermost cobble shell is assigned to the grain.
`fillTraps.m` | Sets the fractional saturation (*n/N*) of the sample's luminescence signal to one. For cobbles, this applies to all depths.
`emptyTraps.m` | Sets the fractional saturation (*n/N*) to zero. 

### Functions to expose a sample to the environment <a name="expose-fxns"></a>
Function | Usage
------------ | -------------
`sunlightExposure.m` | Expose a cobble or grain to sunlight.
`underwaterSunlightExposure.m` | Expose a cobble or grain to sunlight attenuated by water.
`darkGrainHeatExposure.m` | Expose a grain to heat but not sunlight.
`rateEqn.m` | Expose a cobble or grain to heat or sunlight (with or without rock or water attenuation). This function is called by the previous three functions.


## Functions to plot a sample's luminescence signal <a name="plot-fxns"></a>
Function | Usage
------------ | -------------
`nN_t_plot.m` | Plots fractional saturation (*n/N*) as a function of time. Use for grains.
`nN_t_d_3dplot.m` | Plots fractional saturation (*n/N*) as a function of time and cobble depth. Use for cobbles.
`nN_final_t_plot.m` | Plots fractional saturation (*n/N*) as a function of cobble depth at the final timestep. Use for cobbles.
`appAge_t_plot.m` | Plots apparent age (ka) as a function of time. Use for grains.
`appAge_t_d_3dplot.m` | Plots apparent age (ka) as a function of time and cobble depth. Use for cobbles.
`appAge_final_t_plot.m` | Plots apparent age (ka) as a function of cobble depth at the final timestep. Use for cobbles.

## Other functions <a name="other-fxns"></a>
All other functions included in the repository are dependencies that should be kept in the same directory as the other files, but will not ordinarily be directly used. 

`splinefit.m` is copyright 2009, Jonas Lundgren. All rights reserved. Retrieved from [MATLAB Central File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/71225-splinefit) in 2019.

`zroots.m` is modified from:
Recktenwald, G., 2006. [Transient, one-dimensional heat conduction in a convectively cooled sphere](http://www.webcitation.org/60nDyv3Yy), Portland State University, Dept. of MME.

# *LuSS* GUI <a name="LuSS-GUI"></a>
NOTE: If any previous version of *LuSS* is installed in your system, it is recommended to remove that installation before installating the newest version. To do so for the MATLAB toolbox installation, go to 'Home > Add-Ons > Manage Add-Ons' and remove the prior version. For the stand-alone, simply delete the *.exe file.

## Installing *LuSS* GUI as MATLAB toolbox <a name="install-toolbox"></a>
*Preferred option, but requires existing MATLAB license and installation*

There are two options for installing this app. If the user has an existing MATLAB license, the app can simply be installed as an app within the MATLAB toolbox environment by downloading and opening the file titled LuSS_GUI_v1_5.mltbx. This is the recommended method, but it requires a MATLAB license, which may be cost-prohibitive for some.

## Installing *LuSS* GUI as standalone application <a name="install-standalone"></a>
*For those without MATLAB license, but requires MATLAB Runtime installation (free)*

Alternately, the user can install a standalone instance of the GUI. For this option, MATLAB Runtime must be installed first. This is a rather large download which can be found on [the MathWorks website](https://www.mathworks.com/products/compiler/mcr/index.html). For more information about the MATLAB Runtime and the MATLAB Runtime installer, see "Distribute Applications" in the MATLAB Compiler documentation in the MathWorks Documentation Center.

Once MATLAB Runtime is installed, the user can download and open the file titled LuSS_GUI_standalone_v1_5.exe to run the standalone GUI.

## GUI description <a name="GUI-description"></a>
For a detailed description of the *LuSS* GUI, including basic app functionality, a typical workflow, and three example applications, please see [Brown, 2025](#B2025).
 
# Reference <a name="Reference"></a>
<a id="B2020">[Brown, N.D., 2020.]</a> Which geomorphic processes can be informed by luminescence measurements? *Geomorphology* 367, 107296. DOI: [10.1016/j.geomorph.2020.107296](https://doi.org/10.1016/j.geomorph.2020.107296)

<a id="B2025">[Brown, N.D., in review.]</a> Introducing a MATLAB-based app for simulating luminescence sample histories. *In review at Quaternary Research*.
