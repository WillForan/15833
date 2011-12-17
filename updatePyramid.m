function volt=updatePyramid(p,i)
 declareGlobals

 %current voltage
 v=pyramidal(p).v;

 %fprintf('time %i, time from last spike %i\n',timeline(i),t);

 %numerator and demonimator sumations
 numerSum=0;
 denomSum=0;


 usedCurrents=[c.Leak c.ATM];

 for j=usedCurrents
     f=currents(j).tau_fall;
     r=currents(j).tau_rise;
     a=currents(j).anorm;
     G=currents(j).G;
     E=currents(j).Erev;

     if(j == c.ATM)
        t = timeline(i) - thetaSpikes(i);
     else
	 %time after spike;
	t = timeline(i) - pyramidal(p).spikeTime;
     end

     %conducatnace
     if (j == c.Leak)
	 g =  1/f;
	 %g = G .*  a .* exp(-t ./ f);
	 %THIS IS WRONG
     else
	 g = G .*  a .* ( exp(-t ./ f) - exp(-t ./ r) );
     end


     numerSum = numerSum + g .* (E-v);
     denomSum = denomSum + g;
 end

 dv = numerSum .* dt ./ (C + dt .* denomSum);

  %pyramidal(p).dv = dv;
 pyramidal(p).v = v + dv;

 %update what will be plotted
 volt = pyramidal(p).v;

end

