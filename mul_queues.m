num_nodes = 30; 
lambda_earth = 1;
num_events = 1000;
num_users = 10;
final_num_events = 0.6*(num_users + 1)*num_events;

inter_event_times = poissrnd(lambda_earth, num_events, 1);
arrival_timestamps = cumsum(inter_event_times);

mean_times = zeros(num_nodes);
mu = abs(randn(num_nodes));
lambda_users = abs(randn(num_nodes, num_users));
epsilon = (1-0.3)*rand(num_nodes, 1) + 0.3;

for i = 1:num_nodes
    [out_timestamps, mean_time] = single_queue(num_users, num_events, mu(i), lambda_users(i, :), arrival_timestamps, epsilon(i), final_num_events);
    arrival_timestamps = out_timestamps;
    mean_times(i) = mean_time;
end

arrival_timestamps

