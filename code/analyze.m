

%load incidence;
germany = readtable('germany_22520-31620.csv').Germany;

ts = zeros(size(germany));
s = zeros(size(germany));
sigma_s = zeros(size(germany));
e = zeros(size(germany));
sigma_e =  zeros(size(germany));
is = zeros(size(germany));
sigma_is =  zeros(size(germany));
ia = zeros(size(germany));
sigma_ia =  zeros(size(germany));

out = 'out';
for t=1:size(ts)
    S_fname = strcat(out,'/S_t',int2str(t));
    E_fname = strcat(out,'/E_t',int2str(t));
    Is_fname = strcat(out,'/Is_t',int2str(t));
    Ia_fname = strcat(out,'/Ia_t',int2str(t));
    
    load(S_fname);
    load(E_fname);
    load(Is_fname);
    load(Ia_fname);
    
    s(t) = mean(S(1,:,2),2);
    sigma_s(t) = std(S(1,:,2));
    e(t) = mean(E(1,:,2),2);
    sigma_e(t) = std(E(1,:,2));
    is(t) = mean(Is(1,:,2),2);
    sigma_is(t) = std(Is(1,:,2));
    ia(t) = mean(Ia(1,:,2),2);
    sigma_ia(t) = std(Ia(1,:,2));
    ts(t) = t;
   
end 

hold on
errorbar(ts,s,sigma_s);

errorbar(ts,e,sigma_e);
errorbar(ts,is,sigma_is);
errorbar(ts,ia,sigma_ia);

set(gca,'YScale','log');
scatter(ts,germany);
legend("Susceptible","Exposed","Reported infected","Unreported infected","Germany Data");
xlabel("time (d)");
ylabel("Counts");