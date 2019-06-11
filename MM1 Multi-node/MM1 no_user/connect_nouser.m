rho = 0.2:0.01:0.8;
mu_node_1 = 7;
mu_node_2 = 1;
num_events = 100000;

lambdas = rho;

W_sim = zeros(1,length(rho));
min_rho = 0;
min_age = 1000;

for i = 1:length(rho)
    [arrival_times_final, arrival_times_in] = first_node_nouser(lambdas(i), mu_node_1, num_events);
    [departure_timestamps_out, final_arrival_times] = other_nodes_nouser(arrival_times_in, arrival_times_final, mu_node_2);
    [W_sim(i)] = av_age_func(departure_timestamps_out, final_arrival_times, num_events);
    if (W_sim(i) < min_age)
        min_age = W_sim(i);
        min_rho = rho(i);
    end
    W_mm1(i) = 1 + 1/(rho(i)) + rho(i)^2/(1-rho(i));
end

figure
plot(rho, W_sim, 'b', 'linestyle', 'none','marker', 's', 'markersize', 8, 'linewidth', 1.5); hold on;
plot(rho, W_mm1,  'b', 'linestyle', '-', 'linewidth', 1.5); 

legend('sims', 'theory'); xlabel('Rho'); ylabel('Average Age');
grid on;
