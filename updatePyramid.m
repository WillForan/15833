function volt=updatePyramid(p,i)
 declareGlobals
 Thres=-57;
 refPer=2;

 %current voltage
 v=pyramidal(p).v;

 %volt stuck at 0 if last spike was 1ms ago
 if(timeline(i) < pyramidal(p).spikeTime + 2)
     fprintf('spiked one ago! %i \n',i);
     pyramidal(p).v = 0;
     volt=0;
     return
 end

 %fprintf('time %i, time from last spike %i\n',timeline(i),t);

 %numerator and demonimator sumations
 numerSum=0;
 denomSum=0;


 usedCurrents=[c.Leak c.ATM c.AHP c.ADP c.Input];

 for j=usedCurrents
     f=currents(j).tau_fall;
     r=currents(j).tau_rise;
     a=currents(j).anorm;
     G=currents(j).G;
     E=currents(j).Erev;

     %Should time differ between currentsc?
     switch(j)
	 case c.ATM
	    t = timeline(i) - thetaSpikes(i);
	 case c.Input
	    t = timeline(i) - inputSpikes(p,i);
	 otherwise
	    t = timeline(i) - pyramidal(p).spikeTime;
     end

     %calculate conducatnace
     if (j == c.Leak)
	 g = G;
     else
	 g = G .*  a .* ( exp(-t ./ f) - exp(-t ./ r) );
     end


     numerSum = numerSum + g .* (E-v);
     denomSum = denomSum + g;
 end

 dv = numerSum .* dt ./ (C + dt .* denomSum);

 %v=0 if just was a spike, othereise, add conductances
 pyramidal(p).v = v + dv;

 %update what will be plotted
 volt = pyramidal(p).v;

 %%FIRE
 % If threshold and
 %as long as more then enough time has passed
 if (...
  volt > Thres && ...
  timeline(i) > pyramidal(p).spikeTime + refPer ...
  )

     fprintf('spike now! %i %i \n',t,i);
     pyramidal(p).spikeTimes=[pyramidal(p).spikeTimes timeline(i)];
     pyramidal(p).spikeTime=timeline(i);
     pyramidal(p).v=0;
     volt = pyramidal(p).v;

    
 end


end

