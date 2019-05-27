num_users = 5;
lambda_users = (0.4-0.1).*abs(randn(1, num_users)) + 0.1;
mu_node = 3;
epsilon_node = 0.5;
num_events = 1000;
num_events_considered = 0.4*(num_users)*num_events;

[arrival_times_in, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);

num_users = 5;
lambda_users = (0.5-0.2).*abs(randn(1, num_users)) + 0.2;
mu_node = 3;
epsilon_node = 0.6;

[arrival_times_in_2, delay, arrival_timestamps_all, departure_timestamps_out_1, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = second_node(departure_timestamps, num_users, lambda_users, mu_node, epsilon_node, largest_time, arrival_times_in);

% subplot(2, 2, 1)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);
% title("Users=5")
% 
% num_users = 10;
% lambda_users = (0.4-0.1).*abs(randn(1, num_users)) + 0.1;
% mu_node = 5;
% epsilon_node = 0.5;
% num_events = 300;
% num_events_considered = 0.4*(num_users)*num_events;
% 
% [arrival_times_in, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);
% 
% num_users = 10;
% lambda_users = (0.4-0.1).*abs(randn(1, num_users)) + 0.1;
% mu_node = 5;
% epsilon_node = 0.6;
% 
% [delay, arrival_timestamps_all, departure_timestamps_out, ground_indices, largest_time_out, buffer_lengths, waiting_times] = other_node(departure_timestamps, num_users, lambda_users, mu_node, epsilon_node, largest_time, arrival_times_in);
% 
% subplot(2, 2, 2)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);
% title("Users=10")
% 
% num_users = 15;
% lambda_users = (0.4-0.1).*abs(randn(1, num_users)) + 0.1;
% mu_node = 7;
% epsilon_node = 0.5;
% num_events = 300;
% num_events_considered = 0.4*(num_users)*num_events;
% 
% [arrival_times_in, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);
% 
% num_users = 15;
% lambda_users = (0.4-0.1).*abs(randn(1, num_users)) + 0.1;
% mu_node = 7;
% epsilon_node = 0.6;
% 
% [delay, arrival_timestamps_all, departure_timestamps_out, ground_indices, largest_time_out, buffer_lengths, waiting_times] = other_node(departure_timestamps, num_users, lambda_users, mu_node, epsilon_node, largest_time, arrival_times_in);
% 
% subplot(2, 2, 3)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);
% title("Users=15")
% 
% num_users = 20;
% lambda_users = (0.4-0.1).*abs(randn(1, num_users)) + 0.1;
% mu_node = 10;
% epsilon_node = 0.5;
% num_events = 300;
% num_events_considered = 0.4*(num_users)*num_events;
% 
% [arrival_times_in, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);
% 
% num_users = 20;
% lambda_users = (0.4-0.1).*abs(randn(1, num_users)) + 0.1;
% mu_node = 10;
% epsilon_node = 0.6;
% 
% [delay, arrival_timestamps_all, departure_timestamps_out, ground_indices, largest_time_out, buffer_lengths, waiting_times] = other_node(departure_timestamps, num_users, lambda_users, mu_node, epsilon_node, largest_time, arrival_times_in);
% 
% subplot(2, 2, 4)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);
% title("Users=20")