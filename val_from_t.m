function [ValOut] = val_from_t(t,duration,ValIn)
%For a given time, produce a value based on input parameters (used for T, d_W and d_R values)

    if length (ValIn) == 1
        ValOut=ValIn;
    elseif ~(length (ValIn) == 3)
        disp('Input variables T, dW, and dR should be length 1 or 3.')
        return
    else
        v0=ValIn(1);
        vF=ValIn(2);
        k=ValIn(3);
        ValOut=(vF - v0)*(t./duration).^k+v0;
    end

end