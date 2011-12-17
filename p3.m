%load global stuff
declareGlobals
C=1; %membrane capacitance is constant

%load currents
loadCurrents;

%store current V, last spike time, state, total g, delt_V
P  = 4;    %number pyrimdal cells
L  = 500;  %Length of experiment (ms)
dt = 1;    %msec change
%S  = L/dt+1; %number samples in simulation

timeline = 0:dt:L;
Vhist    = zeros(P,length(timeline));


%% set up pyramidal cell values
for p=1:P;
  pyramidal(p).v         = -60;
  pyramidal(p).spikeTime = 0;
  pyramidal(p).s         = 0;
  pyramidal(p).g         = 0;
  pyramidal(p).dv        = 0;
end
%%%%%%%%

%%%%%%%% Theta spike time position %%%%%%
%8HZ => 1000/8 => 125
%500/125 = 4  
period=1000/8;
thetaSpikes=zeros(1,length(timeline));
numThetaSpikes=ceil(L/period)-1;
for i=0:numThetaSpikes;
  if(i.*period > length(thetaSpikes))
      break
  end
  idx=[1:period]+(period*i);
  thetaSpikes(idx)=ones(1,period).*(period.*i);
end

%Fill in last part of the spikes
last=period*(numThetaSpikes+1)+1;
leftover=length(thetaSpikes)+1-last;
if (leftover>0)
   thetaSpikes(last:end)=ones(1,leftover).*(last-1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% MAIN  %%%%%%%%%%
for i=1:length(timeline);
    for p=1:P;
      Vhist(p,i) = updatePyramid(p,i);
    end
end
%%%%%%%%%%%%%%%%%%%%

%make plot
fig=figure;
plot(timeline,Vhist);
hgexport(fig,'../img/3-2');

min(min(Vhist))
