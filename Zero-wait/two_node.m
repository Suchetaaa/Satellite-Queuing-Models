%Plots the Average AoI for zero-wait, poisson and periodic tandem queues in
%one figure

%Rho array (Rho is defined as mu_node_1/mu_node_2)
rho = 0.3:0.001:0.8;
lambda = 0.1;

[av_age_simulation, av_age_theoretical] = zero_wait(rho);
[av_age_poisson_simulation, av_age_poisson_theoretical] = poisson(rho, lambda);
[av_age_periodic_simulation, av_age_periodic_theoretical] = periodic(rho, lambda);

figure
plot(rho, av_age_simulation, 'b', 'linestyle', 'none','marker', 's', 'markersize', 3, 'linewidth', 1.5); hold on;
%plot(rho, av_age_theoretical,  'b', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(rho, av_age_poisson_simulation, 'g', 'linestyle', 'none','marker', 's', 'markersize', 3, 'linewidth', 1.5); hold on;
plot(rho, av_age_periodic_simulation, 'r', 'linestyle', 'none','marker', 's', 'markersize', 3, 'linewidth', 1.5); 

legend('Zerowait', 'Poisson', 'Periodic'); xlabel('Rho'); ylabel('Average Age');
grid on;

