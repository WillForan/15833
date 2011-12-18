function volt=updatePyramid(p,i)
 declareGlobals

 %spike threashold
 Thres=-57;
 %Refactory period
 refPer=2;

 %current voltage
 v=pyramidal(p).v;

 %volt stuck at 0 if last spike was 1ms ago
 if(timeline(i) == pyramidal(p).spikeTime + 1)
     %fprintf('spiked one ago! %i \n',i);
     pyramidal(p).v = 0;
     volt=0;
     return
 end

 %fprintf('time %i, time from last spike %i\n',timeline(i),t);

 %numerator and demonimator sumations
 numerSum=0;
 denomSum=0;


 %usedCurrents=[c.Leak];				%3-1 %also initialize pryramid.v=100 %set ylim to see as demonstrated
 %usedCurrents=[c.Leak c.ATM];			  	%3-2 %also initialize pryramid.v=100 
 %usedCurrents=[c.Leak c.ATM c.AHP c.ADP c.Input];	%step 4 %setInput(1,100); setInput(2,225);
 usedCurrents=[c.Leak c.ATM c.AHP c.ADP c.Input c.GIN]; %step 5 %setInput(2,575)

 for j=usedCurrents
     %waste time making one letter shortcuts
     f=currents(j).tau_fall;
     r=currents(j).tau_rise;
     a=currents(j).anorm;
     G=currents(j).G;
     E=currents(j).Erev;

     %Should time differ between currentsc?
     switch(j)
	 case c.ATM   %Theta
	    t = timeline(i) - thetaSpikes(i);
	 case c.GIN %Gamma
	    t = timeline(i) - gammaNeuron.spikeTime;
	 case c.Input %Input
	    t = timeline(i) - inputSpikes(p,i);
	 otherwise    %current of the cell
	    t = timeline(i) - pyramidal(p).spikeTime;
     end
     if(t<0)
         fprintf('ERR in time: %i %i %i\n',j,t,i);
     end

     %calculate conducatnace
     if (j == c.Leak)
	 g = G;
     else
	 g = G .*  a .* ( exp(-t ./ f) - exp(-t ./ r) );
     end


     numerSum = numerSum + g .* (E-v);
     denomSum = denomSum + g;
     %Move dt inside summation like written in paper
     %numerSum = numerSum + g .* dt .* (E-v);
     %denomSum = denomSum + dt .* g;
     %and then dv is
     % dv = numerSum  ./ (C + denomSum);
 end

 dv = numerSum .* dt ./ (C + dt .* denomSum);

 %update what will be plotted
 volt = pyramidal(p).v + dv;

 %%FIRE
 % If threshold and
 %as long as more then enough time has passed
 if (...
  volt > Thres && ...
  timeline(i) > pyramidal(p).spikeTime + refPer+1 ... 
  )
     %fprintf('spike now! %i %.2f\n',i,volt);

     %set volt to 0
     volt = 0;

     %update spike time collectors
     pyramidal(p).spikeTimes=[pyramidal(p).spikeTimes timeline(i)];
     pyramidal(p).spikeTime=timeline(i);
 end

 %update cell voltage
 pyramidal(p).v = volt;

 %%% could update Vhist here
 %%% but clearer to do so in the main for loop



end

