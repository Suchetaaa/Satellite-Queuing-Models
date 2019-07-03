nodes = 1:20;
% lambda = [1.5 1.8 2.2 2.7 3.5];
num_users = 5;
% av_age_nodes = zeros(length(lambda), length(nodes));
offset_users = (0.5 - 0).*rand(length(nodes), num_users);

% for b = 1:length(lambda)

%     b
epsilon_node = 0.9;
lambda_users = 1.*ones(length(nodes), num_users);
higher = 1*1.5;
num_events = 1000;

prob_sucess_sim = zeros(1, length(nodes));
prob_sucess_theoretical = zeros(1, length(nodes));

for k = 1:length(nodes)

    k
    num_nodes = nodes(k);
    mu_node = num_users*higher;
    num_events_considered = round(0.4*(num_events)*(num_users));

    [packets_out_sim, packets_out_theoretical, ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered);

    for i = 2:num_nodes
        packets_in_sim = packets_out_sim;
        packets_in_theoretical = packets_out_theoretical;
        mu_node = (num_users*i)*higher;
        [packets_out_sim, packets_out_theoretical, arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(packets_in_sim, packets_in_theoretical, departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices);
        final_arrival_times = arrival_times_out;
        departure_timestamps = departure_timestamps_out;
        ground_indices = ground_indices_out;
        largest_time = largest_time_out;
    end

    prob_sucess_theoretical(1, k) = epsilon_node^(num_nodes);
    dummy = packets_out_theoretical/(epsilon_node^(num_nodes));
    prob_sucess_sim(1, k) = packets_out_sim/dummy;

%         av_age_nodes(b, k) = av_age_func(departure_timestamps, final_arrival_times, length(final_arrival_times));

end

plot(nodes, prob_sucess_theoretical,  'b', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(nodes, prob_sucess_sim,  'r', 'linestyle', '-', 'linewidth', 1.5); 
% plot(nodes, av_age_nodes(3, :),  'g', 'linestyle', '-', 'linewidth', 1.5); hold on;
% plot(nodes, av_age_nodes(4, :),  'k', 'linestyle', '-', 'linewidth', 1.5); hold on;
% plot(nodes, av_age_nodes(5, :),  'c', 'linestyle', '-', 'linewidth', 1.5); 

legend('Theoretical', 'Simulation'); xlabel('Number of Nodes'); ylabel('Prob of Success');

grid on;
