%load global stuff
declareGlobals
C=1; %membrane capacitance is constant

%load currents
loadCurrents;

%store current V, last spike time, state, total g, delt_V
P  = 4;    %number pyrimdal cells
L  = 1510;  %Length of experiment (ms)
dt = 1;    %msec change
%S  = (L+1)/dt; %number samples in simulation always starting at 0

timeline = 0:dt:L;
Vhist    = zeros(P,length(timeline));
Ghist    = zeros(1,length(timeline));

thetaSpikes = ones(1,length(timeline)).*-Inf;
inputSpikes = ones(P,length(timeline)).*-Inf;

%% set up pyramidal cell values
for p=1:P;
  pyramidal(p).v          = -60;
  pyramidal(p).spikeTime  = -Inf;
  pyramidal(p).spikeTimes = [];
 % pyramidal(p).state      = [];
 % pyramidal(p).g          = 0;
 % pyramidal(p).dv         = 0;
end
%%%%%%%%

%%%%%%%% Theta spike time position %%%%%%
%8HZ => 1000/8 => 125
%500/125 = 4  
%
%% dt=1 is abused here I thinks
period=1000/8;
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



%%%%%% Input spikes

setInput(1,100);
setInput(2,225);
setInput(3,355);
setInput(4,605);

%%%%%

%%%% GAMMA inter neuron %%%%
gammaNeuron.v          = -60;
gammaNeuron.spikeTime  = -Inf;
gammaNeuron.spikeTimes = [];


%%%%%%%%%%%%%%%%

%%% MAIN  %%%%%%%%%%
for i=1:length(timeline);
    for p=1:P;
      Vhist(p,i) = updatePyramid(p,i);
    end
  %should this be done before or after pyramid?
  Ghist(i) = updateGamma(i);
end
%%%%%%%%%%%%%%%%%%%%


%%%%%%%make plot%%%%%%%%%
%fig=figure;
plot(timeline,[Vhist;Ghist./10+-80]);
%ylim([-90 0]);
%hgexport(fig,'../img/4-2');
%%%%%%%%%%%%%%%%%%%%

%min and max for fun
[min(min(Vhist)) max(max(Vhist))]

