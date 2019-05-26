num_users = 10;
lambda_users = (0.5-0.2).*abs(randn(1, num_users)) + 0.2;
mu_node = 0.25;
epsilon_node = 0.5;
num_events = 100;
num_events_considered = 0.4*(num_users)*num_events;

[departure_timestamps, waiting_times, buffer_lengths, last_index] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);



num_users = 10;
lambda_users = (0.5-0.2).*abs(randn(1, num_users)) + 0.2;
mu_node = 0.25;
epsilon_node = 1;

j = other_node(departure_timestamps, num_users, lambda_users, mu_node, epsilon_node, last_index);
departure_timestamps