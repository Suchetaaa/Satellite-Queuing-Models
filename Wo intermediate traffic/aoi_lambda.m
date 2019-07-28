% nodes = 1:20;
nodes = 2;
lambda = 0.1:0.01:0.9;
num_users = 5;
av_age_nodes = zeros(1, length(lambda));
offset_users = (0.5 - 0).*rand(nodes, num_users);

for b = 1:length(lambda)

    lambda(b)
    epsilon_node = 0.9;
    lambda_users = lambda(b).*ones(nodes, num_users);
    num_events = 3000;

    num_nodes = nodes;
    mu_node = 1;
    num_events_considered = round(0.4*(num_events)*(num_users));

    [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered);

    for i = 2:num_nodes

        ground_indices;
        mu_node = 1;
        [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices);
        final_arrival_times = arrival_times_out;
        departure_timestamps = departure_timestamps_out;
        ground_indices = ground_indices_out;
        largest_time = largest_time_out;
    end

    av_age_nodes(1, b) = av_age_func(departure_timestamps, final_arrival_times, length(final_arrival_times));

end
    
% end

plot(lambda, av_age_nodes, 'b', 'linestyle', '-', 'linewidth', 1.5);
ylabel('AoI'); xlabel('Lambdas');
grid on;

% plot(nodes, av_age_nodes(1, :),  'b', 'linestyle', '-', 'linewidth', 1.5); hold on;
% plot(nodes, av_age_nodes(2, :),  'r', 'linestyle', '-', 'linewidth', 1.5); hold on;
% plot(nodes, av_age_nodes(3, :),  'g', 'linestyle', '-', 'linewidth', 1.5); hold on;
% plot(nodes, av_age_nodes(4, :),  'k', 'linestyle', '-', 'linewidth', 1.5); hold on;
% plot(nodes, av_age_nodes(5, :),  'c', 'linestyle', '-', 'linewidth', 1.5); 
% 
% legend('1.5', '1.8', '2.2', '2.7', '3.5'); xlabel('Number of nodes'); ylabel('AoI');
% 
% grid on;
