function [sampleOut] = makeSampleFeldspar(sampleIn)
% Assigns basic default luminescence parameters to a sample structure

sampleOut=sampleIn;

% basic properties
sampleOut.D0=225;%Gy
sampleOut.Ddot=4;%Gy/ka
sampleOut.s=1e14*3600*24*365.25*1e3;%ka^-1; arbitrary (e.g., Brown and Rhodes, 2017)
sampleOut.E=1.7;%eV; Murray et al. (2009)
sampleOut.sigmaPhi0=6.1e7;%ka^-1; chosen to fit Colarossi et al. (2015) IR50 data; Compare with Ou et al. (2018), Fig. 3 for similar results with top rock slices
sampleOut.mu_R=1.0;%mm^-1

sampleOut.type='feldspar';

end
