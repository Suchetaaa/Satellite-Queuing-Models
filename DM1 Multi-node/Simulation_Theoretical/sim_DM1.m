% Used to verify theoretical and simulated results
%Accompanying function - averae_age.m

rho = 0.2:0.01:0.8;
lambdas = rho;

W_sim = zeros(1,length(rho));
min_rho = 0;
min_age = 1000;

for i = 1:length(rho)
    [W_sim(i)] = average_age(lambdas(1, i), 100000);
    if (W_sim(i) < min_age)
        min_age = W_sim(i);
        min_rho = rho(i);
    end
    beta = -1*rho(i)*lambertw((-1/rho(i)) * (exp(-1/rho(i))));
    
    %Theoretical
    W_dm1(i) = 1/(2*rho(i)) + 1/(1-beta);
end

% W_mm1 = 1 + 1./rho + (rho.^2)./(1-rho);

figure
plot(rho, W_sim, 'b', 'linestyle', 'none','marker', 's', 'markersize', 8, 'linewidth', 1.5); hold on;
plot(rho, W_dm1,  'b', 'linestyle', '-', 'linewidth', 1.5); 

legend('sims', 'theory'); xlabel('Rho'); ylabel('Average Age');
grid on;
