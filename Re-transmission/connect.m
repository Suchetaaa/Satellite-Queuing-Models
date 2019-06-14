offset_users = zeros(10, 10);
for i = 1:10
%     epsilon_node(i) = (0.8-0.5).*rand(1, 1) + 0.5;
    epsilon_node(i) = 0.9;
    offset_users(i, :) = (0.7 - 0).*rand(1, 10) + 0;
end

lambda_users = (3-0).*rand(10, num_users) + 0;
% lambda_users = ones(10, 5);
higher = 5;

num_nodes = 2;
num_users = 5;
    
mu_node = num_users*higher ;
num_events = 2000;
num_events_considered = 0.4*(num_users)*num_events;

[ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node_retr(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);


for i = 2:num_nodes
%     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
    mu_node = (num_users*i)*higher;
    
    [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_node_retr(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :) ,mu_node, epsilon_node(i), largest_time, final_arrival_times, ground_indices);
    final_arrival_times = arrival_times_out;
    departure_timestamps = departure_timestamps_out;
    ground_indices = ground_indices_out;
    largest_time = largest_time_out;
end

departure_timestamps_retr = departure_timestamps(ground_indices');
ground_indices_retr = ground_indices;
final_arrival_times_retr = final_arrival_times;


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

departure_timestamps = departure_timestamps(ground_indices');
times = common_scale(departure_timestamps_retr, departure_timestamps);

av_age_retr = avage_time(departure_timestamps_retr, final_arrival_times_retr, times);
av_age_normal = avage_time(departure_timestamps, final_arrival_times, times);

figure
plot(times, av_age_retr, 'b', 'linestyle', 'none','marker', 's', 'markersize', 2, 'linewidth', 1); hold on;
plot(times, av_age_normal,  'r', 'linestyle', 'none','marker', 's', 'markersize', 2, 'linewidth', 1); 

legend('With Re-transmission', 'Without Re-transmission'); xlabel('Times'); ylabel('AoI'); title('Nodes=4');
grid on;











    


