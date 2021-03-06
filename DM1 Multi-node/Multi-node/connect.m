%Code that connects the 'first_node' and 'other_nodes' and plots various
%interesting parameters

offset_users = zeros(10, 5);

for i = 1:10
%     epsilon_node(i) = (0.8-0.5).*rand(1, 1) + 0.5;
    epsilon_node(i) = 0.9;
    offset_users(i, :) = (0.5 - 0).*rand(1, 5) + 0;
end

%     lambda_users = (0.4-0.1).*rand(10, num_users) + 0.1;
lambda_users = ones(10, 5);
higher = 2;
    
mu_node = num_users*higher ;
num_events = 5000;
num_events_considered = 0.4*(num_users)*num_events;

%-----------------------------------------------------------------------------------
%Subplot 1

num_nodes = 2;
num_users = 5;
[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);


for i = 2:num_nodes
%     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
    mu_node = (num_users*i)*higher;
    
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :) ,mu_node, epsilon_node(i), largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end

subplot(2, 2, 1)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);

delay_end2end = departure_timestamps(ground_indices') - arrival_times_out';
% [~, m] = size(delay_end2end);
% plot(1:m, delay_end2end');

[cdf_out, delay_sorted] = cdf(delay_end2end);
plot(delay_sorted, cdf_out);
av_age(1) = av_age_func(departure_timestamps(ground_indices'), arrival_times_out');
title("Nodes=2");

min_delay(1) = min(delay_end2end);
max_delay(1) = max(delay_end2end);
% average_buff_length(1) = sum(buffer_lengths)/m;

%----------------------------------------------------------------------------------------
%Subplot 2

num_nodes = 5;
num_users = 5;

% lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
mu_node = num_users*higher ;
num_events = 5000;
num_events_considered = 0.4*(num_users)*num_events;

[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);


for i = 2:num_nodes
%     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
    mu_node = (num_users*i)*higher;
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node(i), largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end

subplot(2, 2, 2)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);

delay_end2end = departure_timestamps(ground_indices') - arrival_times_out';
% [~, m] = size(delay_end2end);
% plot(1:m, delay_end2end');

[cdf_out, delay_sorted] = cdf(delay_end2end);
plot(delay_sorted, cdf_out);
av_age(2) = av_age_func(departure_timestamps(ground_indices'), arrival_times_out');
title("Nodes=5");

min_delay(2) = min(delay_end2end);
max_delay(2) = max(delay_end2end);
% average_buff_length(2) = sum(buffer_lengths)/m;

%--------------------------------------------------------------------------------
%Subplot 3

num_nodes = 7;
num_users = 5;

% lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
mu_node = num_users*higher;
num_events = 5000;
num_events_considered = 0.4*(num_users)*num_events;

[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);


for i = 2:num_nodes
%     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
    mu_node = (num_users*i)*higher;
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node(i), largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end

subplot(2, 2, 3)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);
delay_end2end = departure_timestamps(ground_indices') - arrival_times_out';
% [~, m] = size(delay_end2end);
% plot(1:m, delay_end2end');
[cdf_out, delay_sorted] = cdf(delay_end2end);
plot(delay_sorted, cdf_out);
av_age(3) = av_age_func(departure_timestamps(ground_indices'), arrival_times_out');
title("Nodes=7");

min_delay(3) = min(delay_end2end);
max_delay(3) = max(delay_end2end);
% average_buff_length(3) = sum(buffer_lengths)/m;

%---------------------------------------------------------------------------------
%Subplot 4

num_nodes = 10;
num_users = 5;

% lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
mu_node = num_users*higher;
num_events = 5000;
num_events_considered = 0.4*(num_users)*num_events;

[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);


for i = 2:num_nodes
%     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
    mu_node = (num_users*i)*higher;
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :), mu_node, epsilon_node(i), largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end

subplot(2, 2, 4)
% [m, ~] = size(buffer_lengths);
% plot(1:m, buffer_lengths);
delay_end2end = departure_timestamps(ground_indices') - arrival_times_out';
% [~, m] = size(delay_end2end);
% plot(1:m, delay_end2end');
[cdf_out, delay_sorted] = cdf(delay_end2end);
plot(delay_sorted, cdf_out);
av_age(4) = av_age_func(departure_timestamps(ground_indices'), arrival_times_out');
title("Nodes = 10");

min_delay(4) = min(delay_end2end);
max_delay(4) = max(delay_end2end);
% average_buff_length(4) = sum(buffer_lengths)/m;


    


