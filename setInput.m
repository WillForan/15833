%%Write spike time 
function setInput(p,ts)
  declareGlobals

  l=length(inputSpikes);
  t=ceil(ts/dt)+1; %start at 0, which is index 1

  %don't overwrite any values ---
  % larger times set up before smaller times
  idx=find(inputSpikes(p,t:end)<t);
  idx=idx+t;

  inputSpikes(p,idx)=ones(1,length(idx)).*t;
end
