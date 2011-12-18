%%%%%%%
% create datastruct for neuron types
%%%%
c.AHP = 1;
currents(c.AHP).tau_rise = 1e-4;
currents(c.AHP).tau_fall = 30;
currents(c.AHP).G = 23;
currents(c.AHP).Erev = -90;
currents(c.AHP).anorm = find_anorm(currents(c.AHP));

c.ADP = 2;
currents(c.ADP).tau_rise = 135-10^-4;
currents(c.ADP).tau_fall = 135;
currents(c.ADP).G = 30;
currents(c.ADP).Erev = -45;
currents(c.ADP).anorm = find_anorm(currents(c.ADP));

c.ATM = 3;
currents(c.ATM).tau_rise = .1;
currents(c.ATM).tau_fall = 8;
currents(c.ATM).G = 10;
currents(c.ATM).Erev = -90;
currents(c.ATM).anorm = find_anorm(currents(c.ATM));

c.GIN = 4;
currents(c.GIN).tau_rise = .01;
currents(c.GIN).tau_fall = 2.5;
currents(c.GIN).G = 150;
currents(c.GIN).Erev = -70;
currents(c.GIN).anorm = find_anorm(currents(c.GIN));

%
c.Leak = 5;
currents(c.Leak).tau_rise = 9;
currents(c.Leak).tau_fall = 9;
currents(c.Leak).G = 111;
currents(c.Leak).Erev = -60;
currents(c.Leak).anorm = 0;% find_anorm(currents(c.Leak));

%Page 3 of Reverse and Forward
%http://www.cs.cmu.edu/afs/cs/academic/class/15883-f11/readings/koene-2008-nn.pdf
c.Input= 6;
currents(c.Input).tau_rise = 1; 
currents(c.Input).tau_fall = 2; %or or 4
currents(c.Input).G = 30; %32? or .6 or .15
currents(c.Input).Erev = 0;
currents(c.Input).anorm = find_anorm(currents(c.Input));


%%%%%%%%% GAMMA
c.GammaAHP = 7;
currents(c.GammaAHP).tau_rise = 1e-4; 
currents(c.GammaAHP).tau_fall = 4;
currents(c.GammaAHP).G = 100; 
currents(c.GammaAHP).Erev = -90;
currents(c.GammaAHP).anorm = find_anorm(currents(c.Input));

c.GammaLeak = 8;
currents(c.GammaLeak).tau_rise = NaN; 
currents(c.GammaLeak).tau_fall = NaN;
currents(c.GammaLeak).G = 100; 
currents(c.GammaLeak).Erev = -70;
currents(c.GammaLeak).anorm = NaN;

c.GammaIn = 9;
currents(c.GammaIn).tau_rise = 1; 
currents(c.GammaIn).tau_fall = 2;
currents(c.GammaIn).G = 30; 
currents(c.GammaIn).Erev = 0;
currents(c.GammaIn).anorm = find_anorm(currents(c.Input));

