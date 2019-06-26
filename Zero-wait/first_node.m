rho = 0.1:0.01:0.9;
av_age_simulation = zeros(1, length(rho));
av_age_theoretical = zeros(1, length(rho));

for j = 1 : length(rho)

mu_node_1 = rho(j);

num_events = 10000;

inter_service_times = 1/mu_node_1*log(1./rand(1,num_events));

arrival_timestamps = cumsum(inter_service_times(1, 1:num_events-1));
arrival_timestamps = [0 arrival_timestamps];

departure_timestamps = cumsum(inter_service_times);

mu_node_2 = 1;

inter_service_times_2 = 1/mu_node_2*log(1./rand(1, num_events));

server_timestamps = zeros(1, num_events);
departure_timestamps_2 = zeros(1, num_events);

server_timestamps(1) = departure_timestamps(1);
departure_timestamps_2(1) = server_timestamps(1) + inter_service_times_2(1);

for i = 2:num_events
    if departure_timestamps(i) < departure_timestamps_2(i-1)
        server_timestamps(i) = departure_timestamps_2(i-1);
    else
        server_timestamps(i) = departure_timestamps(i);
    end
    departure_timestamps_2(i) = server_timestamps(i) + inter_service_times_2(i);
end

    av_age_simulation(1, j) = av_age_func(departure_timestamps_2, arrival_timestamps);
    av_age_theoretical(1, j) = 1 + 2/rho(j) + rho(j)*(2*(rho(j)^2) - rho(j) + 1)/((1 - rho(j))*(1 + rho(j)));

end


plot(rho, av_age_simulation, 'b', 'linestyle', 'none','marker', 's', 'markersize', 8, 'linewidth', 1.5); hold on;
plot(rho, av_age_theoretical,  'b', 'linestyle', '-', 'linewidth', 1.5); 
legend('Simulated', 'Theoretical'); xlabel('Rho(mu1/mu2)'); ylabel('AoI');
