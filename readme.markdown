# OVERVIEW

[Project Page](http://www.cs.cmu.edu/afs/cs/academic/class/15883-f11/handouts/modeling-project.html)

> Short-term persistent spiking buffer model of entorhinal cortex described by Randal A. Koene and Michael E. Hasselmo

[Writeup](https://github.com/WillForan/15833/raw/master/writeups/writeup.pdf)
## OUTPUT 

> octave runSim.m


    Cell	1
    time	102    212    322    432    543    658    778    902   1027   1152   1277   1402
    ISI		110   110   110   111   115   120   124   125   125   125   125
    Phase	102    87    72    57    43    33    28    27    27    27    27    27

    Cell	2
    time   	227    340    451    562    675    794    917   1041   1166   1291   1416
    ISI	   	113   111   111   113   119   123   124   125   125   125
    Phase	102    90    76    62    50    44    42    41    41    41    41

    Cell	3
    time	357    469    581    693    810    931   1055   1180   1305   1430
    ISI		112   112   112   117   121   124   125   125   125
    Phase	107    94    81    68    60    56    55    55    55    55

    Cell	4
    time	607    717    829    946   1069   1194   1319   1444
    ISI	   	110   112   117   123   125   125   125
    Phase	107    92    79    71    69    69    69    69

<a href="https://github.com/WillForan/15833/raw/master/writeups/img/5.png"><img src="https://github.com/WillForan/15833/raw/master/writeups/img/5.png" width="50%" height="50%"></a>
<a href="https://github.com/WillForan/15833/raw/master/writeups/img/5-subplots.png"><img src="https://github.com/WillForan/15833/raw/master/writeups/img/5-subplots.png" width="50%" height="50%"></a>

## Code

### runSim.m

1. initialize
    1. load currents (own file)
    1. # pyramidal cells=4, length of simulation=1510
    1. pyramidal cells and gammaNeuron to v=-60 and spiketime=-Inf
    1. thetaSpikes =  [ 0.\*[1x125]; 125 .\*[1x125]; ...;4.\*125/\*[1x125] ]
    1. setinputs to pyrimdal cells ( 1,100 2,225  3,355 4,605)
1. for each step of stimulation
    1. for each pyramidal cell
        1. update this pyramidal cell voltage 
    1. update gamma cell voltage
1. collect stats
1. plot gamma and pyramidal cells

### updatePyramidal/Gamma

1. if cell spiked within last millisecond
    1. v =0
    1. return %don't do anything else
1. for j as each current (leak, theta, ahp, adp, input, gamma)
    1. get "t" 
        1. if current is theta use theta spikes
        1. if current is gamma use gammaNueron spike time
        1. otherwise use this pyramidal cell's spike time
    1. calculate "g"
        1. using above t and currents(j).tau\_fall ...anrom, G, Erev 
    1.  add to numerator num=num+g.\*(E-v) and denominator denom=denom+num+g portions of deltaV sum 
1. calculate detaV using collected sums=> num*dt /(1+dt *denom)
1. if voltage is above thres AND timeline(i) > spiketime+2ms
    1. voltage = 0
1. update volt of pyrmidal(p)
1. update Vhist(p,i) = voltage 


