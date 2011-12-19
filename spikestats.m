function spikestats
  declareGlobals

  for p=1:P
      spikeTimes = pyramidal(p).spikeTimes;
      phase	 = mod(spikeTimes,125)./125;
      cycle	 = ceil(spikeTimes./125);
      ISI        = spikeTimes(2:end) - spikeTimes(1:end-1);

      indent='	';
      for i=1:min(cycle)
	indent=[indent '	'];
      end

      fprintf('\nCell\t%i\n',p);
      fprintf('spiketime(ms)       %s',indent);		fprintf('%i\t',spikeTimes);	fprintf('\n');
      fprintf('ISI(ms)             \t%s',indent);	fprintf('%i\t',ISI);		fprintf('\n');
      fprintf('Phase(percent cycle)%s',indent);		fprintf('%.2f\t',phase); 	fprintf('\n');
      fprintf('Theta cycle         %s',indent);		fprintf('%i\t',cycle);	 	fprintf('\n');
  end

end
