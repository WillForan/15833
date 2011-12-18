%%% function to find simulation value of anorm
function anorm = find_anorm(cur)
    declareGlobals
    %%%
    %using discrite
    %%%
    t       = [0:.001:cur.tau_fall];
    expdiff = exp(-t ./ cur.tau_fall) - exp(-t ./ cur.tau_rise);
    anorm   = 1/max(expdiff);

    %if(cur.tau_fall ~=cur.tau_rise)
    %    expdiff = exp(-t ./ cur.tau_fall) - exp(-t ./ cur.tau_rise);
    %else
    %    expdiff = exp(-t ./ cur.tau_fall);
    %end
    %anorm   = 1/max(expdiff);

    %%%
    %using deriviative
    %%%
    %t_max =  log(cur.tau_fall ./ cur.tau_rise)	...
    %    	./				...
    %    (cur.tau_rise.^-1 - cur.tau_fall.^-1);
    %anorm = 1./( exp( - t_max ./ cur.tau_fall) - exp( -t_max./ cur.tau_rise) );
end
