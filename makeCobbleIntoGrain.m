function [sampleOut] = makeCobbleIntoGrain(sampleIn)
% Takes n/N value at uppermost slice and assigns that as the singular n/N value for the sample

sampleOut=sampleIn;

    if length(sampleOut.nN)==1%if sample is already a grain, just say so
        disp('Sample is already a grain. Doing nothing.')
    else
        val=sampleOut.nN(1,2);
        sampleOut.nN=val;
        sampleOut.size='grain';
    end

end
