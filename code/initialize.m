function [x,paramax,paramin]=initialize(pop,M,num_ens)
%Initialize the metapopulation SEIRS model
%load M %load mobility
num_loc=size(pop,1);
% num_var=5*num_loc+6;
% S,E,Is,Ia,obs,...,beta,mu,theta,Z,alpha,D
% prior range
Slow=1.0;Sup=1.0;%susceptible fraction
Elow=0;Eup=0;%exposed
Irlow=0;Irup=0.0;%documented infection
Iulow=0;Iuup=0.0;%undocumented infection
obslow=0;obsup=0;%reported case

[betalow,betaup,mulow,muup, thetalow, thetaup, Zlow, Zup, alphalow, alphaup, Dlow, Dup] = init_parameters();

%range of model state including variables and parameters
xmin=[];
xmax=[];
for i=1:num_loc
    xmin=[xmin;Slow*pop(i);Elow*pop(i);Irlow*pop(i);Iulow*pop(i);obslow];
    xmax=[xmax;Sup*pop(i);Eup*pop(i);Irup*pop(i);Iuup*pop(i);obsup];
end
xmin=[xmin;betalow;mulow;thetalow;Zlow;alphalow;Dlow];
xmax=[xmax;betaup;muup;thetaup;Zup;alphaup;Dup];
paramax=xmax(end-5:end);
paramin=xmin(end-5:end);
%seeding
%Germany - 1
seedid=1;
%E
xmin((seedid-1)*5+2)=100;
xmax((seedid-1)*5+2)=100;
%Is
xmin((seedid-1)*5+3)=17;
xmax((seedid-1)*5+3)=17;
%Ia
xmin((seedid-1)*5+4)=83;
xmax((seedid-1)*5+4)=83;

%Latin Hypercubic Sampling
x=lhsu(xmin,xmax,num_ens);
x=x';
for i=1:num_loc
    x((i-1)*5+1:(i-1)*5+4,:)=round(x((i-1)*5+1:(i-1)*5+4,:));
end
%seeding in other cities
C=M(:,seedid,1);%first day
for i=1:num_loc
    if i~=seedid
        %E
        Elocus=x((seedid-1)*5+2,:);
        x((i-1)*5+2,:)=round(C(i)*3*Elocus/pop(seedid));
        %Ia
        Ialocus=x((seedid-1)*5+4,:);
        x((i-1)*5+4,:)=round(C(i)*3*Ialocus/pop(seedid));
    end
end

function s=lhsu(xmin,xmax,nsample)
nvar=length(xmin);
ran=rand(nsample,nvar);
s=zeros(nsample,nvar);
for j=1: nvar
   idx=randperm(nsample);
   P =(idx'-ran(:,j))/nsample;
   s(:,j) = xmin(j) + P.* (xmax(j)-xmin(j));
end
