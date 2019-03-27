function [sampleOut] = makeSampleCobble(sampleIn,cobbleRadius,spacing)
% Changes nN field from value to matrix with two columns. First is depth array.
%   Second column contains identical entries equal to nN value.
%   If not previously defined, nN is treated as 1.

sampleOut=sampleIn;

    if ~isfield(sampleOut,'nN')%if not previously defined,
        sampleOut.nN=1;%define as 1
    elseif length(sampleOut.nN) > 1%or, if sample is already a cobble, do nothing
        disp('Sample is already a cobble. Doing nothing.')
    else
        val=sampleOut.nN;

        depthArray=[0:spacing:cobbleRadius]';
        nNarray=val*ones(length(depthArray),1);

        sampleOut.nN=[depthArray nNarray];
        
        sampleOut.size='cobble';
    end
end
