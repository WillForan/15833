function volt=updateGamma(i)
 declareGlobals

 %spike threashold
 Thres=-57;
 %Refactory period
 refPer=2;

 %current voltage
 v=gammaNeuron.v;

 %volt stuck at 0 if last spike was 1ms ago
 if(timeline(i) <= gammaNeuron.spikeTime + 1)
     %fprintf('spiked one ago! %i \n',i);
     gammaNeuron.v = 0;
     volt=0;
     return
 end


 %numerator and demonimator sumations
 numerSum=0; denomSum=0;


 usedCurrents=[c.GammaLeak c.GammaAHP c.GammaIn];

 for j=usedCurrents
     f=currents(j).tau_fall;
     r=currents(j).tau_rise;
     a=currents(j).anorm;
     G=currents(j).G;
     E=currents(j).Erev;

     %Should time differ between currentsc?
     switch(j)
	 case c.GammaIn %Input
	    t = timeline(i) - max([pyramidal.spikeTime]);
	 otherwise    %current of the cell
	    t = timeline(i) - gammaNeuron.spikeTime;
     end

     if(t<0)
         fprintf('ERR in time: %i %i %i\n',j,t,i);
     end

     %calculate conducatnace
     if (j == c.GammaLeak) g = G; else
	 g = G .*  a .* ( exp(-t ./ f) - exp(-t ./ r) );
     end


     numerSum = numerSum + g .* (E-v);
     denomSum = denomSum + g;
 end

 dv = numerSum .* dt ./ (C + dt .* denomSum);

 %v=0 if just was a spike, othereise, add conductances
 gammaNeuron.v = v + dv;

 %update what will be plotted
 volt = gammaNeuron.v;

 %%FIRE
 % If threshold and
 %as long as more then enough time has passed
 if (...
  volt > Thres && ...
  timeline(i) > gammaNeuron.spikeTime + refPer ...
  )

     %fprintf('spike now! %i %i \n',t,i);
     gammaNeuron.spikeTimes=[gammaNeuron.spikeTimes timeline(i)];
     gammaNeuron.spikeTime=timeline(i);

     gammaNeuron.v=0; %spike hieght
     volt = gammaNeuron.v;

    
 end


end

