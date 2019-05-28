num_nodes = 10;
num_users = 10;

lambda_users = (0.4-0.1).*abs(randn(1, num_users)) + 0.1;
mu_node = 3;
epsilon_node = 0.5;
num_events = 3000;
num_events_considered = 0.4*(num_users)*num_events;

[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);


for i = 2:num_nodes
    lambda_users = (0.4-0.1).*abs(randn(1, num_users)) + 0.1;
    mu_node = num_users*0.4 + i;
    epsilon_node = (0.8-0.4).*rand(1, 1) + 0.4;
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users, mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end
    


