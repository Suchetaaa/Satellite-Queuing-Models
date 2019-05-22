num_nodes = 160; 
lambda_earth = 1;
num_events = 100;
num_users = 10;

inter_event_times = poissrnd(lambda_earth, num_events, 1);
arrival_timestamps = cumsum(inter_event_times);

mean_times = zeros(num_nodes);
mu = abs(randn(num_nodes));
lambda_users = abs(randn(num_nodes, num_users));
epsilon = (1-0.3)*rand(num_nodes, 1) + 0.2;

for i = 1:num_nodes
    [out_timestamps, mean_time] = single_queue(num_users, num_events, mu(i), lambda_users(i, :), arrival_timestamps, epsilon(i));
    arrival_timestamps = out_timestamps;
    mean_times(i) = mean_time;
end

arrival_timestamps

