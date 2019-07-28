%Plots Average AoI Vs Number of Nodes for a chosen lambda value and
%retransmissions - 0, 1, 2, 3, 4 on the same figure

%Sweeps through all these nodes
nodes = 1:30;

lambda = [1.5 1.8 2.2 2.7 3.5];
num_users = 5;
av_age_nodes = zeros(5, length(nodes));
offset_users = (0.5 - 0).*rand(length(nodes), num_users);

b = 2;
epsilon_node = 0.9;
lambda_users = lambda(b).*ones(length(nodes), num_users);
higher = lambda(b)*1.5;
num_events = 3000;

%Retransmissions - 0
for k = 1:length(nodes)
    k
    num_nodes = nodes(k);
    mu_node = num_users*higher;
    num_events_considered = round(0.4*(num_events)*(num_users));
    [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node_retr_0(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered);
    for i = 2:num_nodes
        mu_node = (num_users*i)*higher;
        [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes_retr_0(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices);
        final_arrival_times = arrival_times_out;
        departure_timestamps = departure_timestamps_out;
        ground_indices = ground_indices_out;
        largest_time = largest_time_out;
    end
    av_age_nodes(1, k) = av_age_func(departure_timestamps(ground_indices'), final_arrival_times, length(final_arrival_times));
end

%Retransmissions - 1
max_retransmissions = 1;
for k = 1:length(nodes)

    k
    num_nodes = nodes(k);
    mu_node = num_users*higher;
    num_events_considered = round(0.4*(num_events)*(num_users));

    [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node_retr_1(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered, max_retransmissions);

    for i = 2:num_nodes

        mu_node = (num_users*i)*higher;
        [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_node_retr_1(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices, max_retransmissions);
        final_arrival_times = arrival_times_out;
        departure_timestamps = departure_timestamps_out;
        ground_indices = ground_indices_out;
        largest_time = largest_time_out;
    end

    av_age_nodes(2, k) = av_age_func(departure_timestamps(ground_indices'), final_arrival_times, length(final_arrival_times));

end

%Retransmissions - 2
max_retransmissions = 2;
for k = 1:length(nodes)

    k
    num_nodes = nodes(k);
    mu_node = num_users*higher;
    num_events_considered = round(0.4*(num_events)*(num_users));

    [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node_retr_2(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered, max_retransmissions);

    for i = 2:num_nodes

        mu_node = (num_users*i)*higher;
        [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_node_retr_2(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices, max_retransmissions);
        final_arrival_times = arrival_times_out;
        departure_timestamps = departure_timestamps_out;
        ground_indices = ground_indices_out;
        largest_time = largest_time_out;
    end

    av_age_nodes(3, k) = av_age_func(departure_timestamps(ground_indices'), final_arrival_times, length(final_arrival_times));

end

%Retransmissions - 3
max_retransmissions = 3;
for k = 1:length(nodes)

    k
    num_nodes = nodes(k);
    mu_node = num_users*higher;
    num_events_considered = round(0.4*(num_events)*(num_users));

    [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node_retr_3(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered, max_retransmissions);

    for i = 2:num_nodes

        mu_node = (num_users*i)*higher;
        [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_node_retr_3(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices, max_retransmissions);
        final_arrival_times = arrival_times_out;
        departure_timestamps = departure_timestamps_out;
        ground_indices = ground_indices_out;
        largest_time = largest_time_out;
    end

    av_age_nodes(4, k) = av_age_func(departure_timestamps(ground_indices'), final_arrival_times, length(final_arrival_times));

end

%Retransmissions - 4
max_retransmissions = 4;
for k = 1:length(nodes)

    k
    num_nodes = nodes(k);
    mu_node = num_users*higher;
    num_events_considered = round(0.4*(num_events)*(num_users));

    [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node_retr_4(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered, max_retransmissions);

    for i = 2:num_nodes

        mu_node = (num_users*i)*higher;
        [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_node_retr_4(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices, max_retransmissions);
        final_arrival_times = arrival_times_out;
        departure_timestamps = departure_timestamps_out;
        ground_indices = ground_indices_out;
        largest_time = largest_time_out;
    end

    av_age_nodes(5, k) = av_age_func(departure_timestamps(ground_indices'), final_arrival_times, length(final_arrival_times));

end

%Plotting
plot(nodes, av_age_nodes(1, :),  'b', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(nodes, av_age_nodes(2, :),  'r', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(nodes, av_age_nodes(3, :),  'g', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(nodes, av_age_nodes(4, :),  'k', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(nodes, av_age_nodes(5, :),  'm', 'linestyle', '-', 'linewidth', 1.5); 

legend('0', '1', '2', '3', '4'); xlabel('Number of nodes'); ylabel('AoI');

grid on;
