%Plots the Average AoI vs Number of Nodes WITHOUT intermediate traffic with
%different lambdas on the same figure

nodes = 1:20;
lambda = [1.5 1.8 2.2 2.7 3.5];
num_users = 5;
av_age_nodes = zeros(length(lambda), length(nodes));
offset_users = (0.5 - 0).*rand(length(nodes), num_users);
max_retransmissions = 2;

for b = 1:length(lambda)

    b
    epsilon_node = 0.9;
    lambda_users = lambda(b).*ones(length(nodes), num_users);
    higher = lambda(b)*1.5;
    num_events = 3000;

    for k = 1:length(nodes)
        
        k
        num_nodes = nodes(k);
        
        %Mu_node is adjusted in such a way that the rho or utilization
        %factor at every node is less than 1
        mu_node = num_users*higher;
        num_events_considered = round(0.4*(num_events)*(num_users));

        [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node_retr_wo(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered, max_retransmissions);

        for i = 2:num_nodes
 
            mu_node = (num_users*i)*higher;
            [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_node_retr_wo(departure_timestamps, mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices, max_retransmissions);
            final_arrival_times = arrival_times_out;
            departure_timestamps = departure_timestamps_out;
            ground_indices = ground_indices_out;
            largest_time = largest_time_out;
        end

        av_age_nodes(b, k) = av_age_func(departure_timestamps, final_arrival_times, length(final_arrival_times));

    end
    
end

%Plotting
plot(nodes, av_age_nodes(1, :),  'b', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(nodes, av_age_nodes(2, :),  'r', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(nodes, av_age_nodes(3, :),  'g', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(nodes, av_age_nodes(4, :),  'k', 'linestyle', '-', 'linewidth', 1.5); hold on;
plot(nodes, av_age_nodes(5, :),  'c', 'linestyle', '-', 'linewidth', 1.5); 

legend('1.5', '1.8', '2.2', '2.7', '3.5'); xlabel('Number of nodes'); ylabel('AoI');

grid on;
