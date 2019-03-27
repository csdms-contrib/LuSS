function [sampleOut] = makeSampleQuartz(sampleIn)
% Assigns basic default luminescence parameters to a sample structure

sampleOut=sampleIn;

% basic properties
sampleOut.D0=150;%Gy
sampleOut.Ddot=2;%Gy/ka
sampleOut.s=2.8e12*3600*24*365.25*1e3;%ka^-1; Spooner and Questiaux (2000)
sampleOut.E=1.59;%eV; Spooner and Questiaux (2000)
sampleOut.sigmaPhi0=1.05e10;%ka^-1; chosen to fit Colarossi grain bleaching
sampleOut.mu_R=0.5;%mm^-1

sampleOut.type='quartz';

end
