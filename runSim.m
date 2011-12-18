%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% runSim %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% Initialize Values %%%%

%%load global stuff
declareGlobals

%%membrane capacitance is constant
C=1;

%%load currents
loadCurrents;

%%store current V, last spike time, state, total g, delt_V
P  = 4;    	%number pyrimdal cells
L  = 1510;  	%Length of experiment (ms)
dt = 1;    	%msec change
S  = (L+1)/dt;  %number samples in simulation always starting at 0

%%initialize simulation timeline and cell histories
timeline = 0:dt:L;
Vhist    = zeros(P,S);
Ghist    = zeros(1,S);

%%initialize inputs to pyrimdal cells (theta and input)
thetaSpikes = ones(1,S).*-Inf;
inputSpikes = ones(P,S).*-Inf;


%% set up pyramidal cell values %% 
for p=1:P;
  pyramidal(p).v          = -60;
  pyramidal(p).spikeTime  = -Inf;
  pyramidal(p).spikeTimes = [];
end

%% GAMMA inter neuron %%%%
gammaNeuron.v          = -60;
gammaNeuron.spikeTime  = -Inf;
gammaNeuron.spikeTimes = [];


%% Theta spike time position %%%%%%
%8HZ => 1000/8 => 125
%500/125 = 4  
%
%% dt=1 is abused here I thinks

period         = 1000/8;
numThetaSpikes = ceil(L/period)-1;

for i=0:numThetaSpikes;
  if(i.*period > length(thetaSpikes))
      break
  end
  idx=[1:period]+(period*i);
  thetaSpikes(idx)=ones(1,period).*(period.*i);
end

%Fill in last part of the spikes
last     = period*(numThetaSpikes+1)+1;
leftover = length(thetaSpikes)+1-last;

if (leftover>0)
   thetaSpikes(last:end)=ones(1,leftover).*(last-1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%% Input spikes

%Part 4
setInput(1,100);
setInput(2,225);

%Part 5-1
%setInput(2,475); %comment out previous

%Part 5-2
setInput(3,355);
setInput(4,605);

%%%%%


%%% MAIN  %%%%%%%%%%
for i=1:S;
  for p=1:P;
    Vhist(p,i) = updatePyramid(p,i);
  end
  %This update must go after (pyr cell fires, supress all others)
  Ghist(i) = updateGamma(i);
end
%%%%%%%%%%%%%%%%%%%%


%%%%% STATS  %%%%%%%
spikestats;
%%%%%%%%%%%%%%%%%%%%


%%%%%%%make plot%%%%%%%%%
%fig=figure;
%plot(timeline,[Vhist;Ghist./10+-80]);
%ylim([-90 0]);
%hgexport(fig,'../img/4-2');

%%Vhist plot gets two vertical panels, gamma gets one
%%both go all the way across
%pyramidal shift down
for p=1:P
    Vhist(p,:)=Vhist(p,:)-4*p;
end
subplot(3,1,[1 2]);
plot(timeline,Vhist);
xlim([0 L]);
xlabel('time (ms)');
ylabel('Membrane Voltage');
title('Pyrimdal Cells');

%gamma
subplot(3,1,3);
plot(timeline,Ghist,'k');
xlim([0 L]);
print('-dpng','simulation.png'); %ocatve print
title('Gamma Neuron');

%%%%%ALL in subplots
%for p=1:P
%    subplot(P+1,1,p);
%    plot(timeline,Vhist(p,:));
%    xlim([0 1510]);
%end
%%%gamma
%subplot(P+1,1,P+1);
%plot(timeline,Ghist,'k');
%xlim([0 1510]);
%
%print('-dpng','5-subplots.png'); %ocatve print
%%hgexport(fig,'../img/4-2'); %matlab
%%%%%%%%%%%%%%%%%%%%%

%min and max for fun
%[min(min(Vhist)) max(max(Vhist))]

