function [betalow,betaup,mulow,muup, thetalow, thetaup, Zlow, Zup, alphalow, alphaup, Dlow, Dup] = init_parameters()
betalow=0.2;betaup=0.8;%transmission rate
mulow=0.2;muup=1.0;%relative transmissibility
thetalow=1;thetaup=1.0;%movement factor
Zlow=3;Zup=10;%latency period
alphalow=0.02;alphaup=0.8;%reporting rate
Dlow=2;Dup=15;%infectious period

end