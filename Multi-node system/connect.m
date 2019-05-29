num_nodes = 2;

for i = 1:10
    epsilon_node(i) = (0.8-0.4).*rand(1, 1) + 0.4;
end
    
num_users = 5;

for i = 1:num_users
    lambda_users = (0.4-0.1).*rand(10, num_users) + 0.1;
end
    
mu_node = num_users*0.4 ;
num_events = 3000;
num_events_considered = 0.4*(num_users)*num_events;

[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);


for i = 2:num_nodes
%     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
    mu_node = num_users*0.4 + i - 1;
    
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), mu_node, epsilon_node(i), largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end

subplot(2, 2, 1)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);

delay_end2end = departure_timestamps(ground_indices') - arrival_times_out';
[~, m] = size(delay_end2end);
plot(1:m, delay_end2end');
title("Nodes=2");

min_delay(1) = min(delay_end2end);
max_delay(1) = max(delay_end2end);
average_buff_length(1) = sum(buffer_lengths)/m;


num_nodes = 5;
num_users = 5;

% lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
mu_node = num_users*0.4 ;
num_events = 3000;
num_events_considered = 0.4*(num_users)*num_events;

[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);


for i = 2:num_nodes
%     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
    mu_node = num_users*0.4 + i - 1;
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), mu_node, epsilon_node(i), largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end

subplot(2, 2, 2)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);

delay_end2end = departure_timestamps(ground_indices') - arrival_times_out';
[~, m] = size(delay_end2end);
plot(1:m, delay_end2end');
title("Nodes=5");

min_delay(2) = min(delay_end2end);
max_delay(2) = max(delay_end2end);
average_buff_length(2) = sum(buffer_lengths)/m;


num_nodes = 7;
num_users = 5;

% lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
mu_node = num_users*0.4;
num_events = 3000;
num_events_considered = 0.4*(num_users)*num_events;

[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);


for i = 2:num_nodes
%     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
    mu_node = num_users*0.4 + i;
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), mu_node, epsilon_node(i), largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end

subplot(2, 2, 3)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);
delay_end2end = departure_timestamps(ground_indices') - arrival_times_out';
[~, m] = size(delay_end2end);
plot(1:m, delay_end2end');
title("Nodes=7");

min_delay(3) = min(delay_end2end);
max_delay(3) = max(delay_end2end);
average_buff_length(3) = sum(buffer_lengths)/m;


num_nodes = 10;
num_users = 5;

% lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
mu_node = num_users*0.4;
num_events = 3000;
num_events_considered = 0.4*(num_users)*num_events;

[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);


for i = 2:num_nodes
%     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
    mu_node = num_users*0.4 + i;
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), mu_node, epsilon_node(i), largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end

subplot(2, 2, 4)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);
delay_end2end = departure_timestamps(ground_indices') - arrival_times_out';
[~, m] = size(delay_end2end);
plot(1:m, delay_end2end');
title("Nodes = 10");

min_delay(4) = min(delay_end2end);
max_delay(4) = max(delay_end2end);
average_buff_length(4) = sum(buffer_lengths)/m;


    


