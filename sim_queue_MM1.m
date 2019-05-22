clear all;
close all;
lambda = 1;
rho = [0.3:0.05:0.8];
mu = lambda./rho;
W_sim = zeros(1,length(rho));

for i = 1:length(rho)
    [W_sim(i)] = mm1(lambda, mu(i), 100000);
end
W_mm1 = rho./mu./(1-rho)+1./mu;

figure
plot(rho, W_sim, 'b', 'linestyle', 'none','marker', 's', 'markersize', 8, 'linewidth', 1.5); hold on;
plot(rho, W_mm1,  'b', 'linestyle', '-', 'linewidth', 1.5); 

legend('sims', 'theory'); xlabel('intensity'); ylabel('mean sojourn time');
grid on;

