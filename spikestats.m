function spikestats
  declareGlobals

  for p=1:P
      spikeTimes = pyramidal(p).spikeTimes;
      phase	 = mod(spikeTimes,125);
      ISI        = spikeTimes(2:end) - spikeTimes(1:end-1);

      fprintf('Cell\t%i\n',p);
      fprintf('time\t');	disp(spikeTimes);
      fprintf('ISI\t');		disp(ISI);
      fprintf('Phase\t');	disp(phase);
  end

end
