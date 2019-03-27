function [sampleOut] = fillTraps(sampleIn)
% Puts all traps to empty

sampleOut=sampleIn;

    if ~isfield(sampleOut,'nN')%if not previously defined,
        sampleOut.nN=1;%define as 1
    elseif length(sampleOut.nN) > 1%or, if sample is a cobble,
        sampleOut.nN(:,2)=1;%all entries to 1
    else
        sampleOut.nN=1;%define as 1
    end

end
