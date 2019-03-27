function [sampleOut] = emptyTraps(sampleIn)
% Puts all traps to empty

sampleOut=sampleIn;

    if ~isfield(sampleOut,'nN')%if not previously defined,
        sampleOut.nN=0;%define as 1
    elseif length(sampleOut.nN) > 1%or, if sample is a cobble,
        sampleOut.nN(:,2)=0;%all entries to 1
    else
        sampleOut.nN=0;%define as 1
    end

end
