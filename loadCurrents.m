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
currents(c.ATM).Erev = -70;
currents(c.ATM).anorm = find_anorm(currents(c.ATM));

c.GIN = 4;
currents(c.GIN).tau_rise = .01;
currents(c.GIN).tau_fall = 2.5;
currents(c.GIN).G = 150;
currents(c.GIN).Erev = -70;
currents(c.GIN).anorm = find_anorm(currents(c.GIN));

%leak is funny, g=c/f = 1/9
c.Leak = 5;
currents(c.Leak).tau_rise = 9;
currents(c.Leak).tau_fall = 9;
currents(c.Leak).G = 111;
currents(c.Leak).Erev = -60;
currents(c.Leak).anorm = 0;% find_anorm(currents(c.Leak));


%%%%%%%%%
