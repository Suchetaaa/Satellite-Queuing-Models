epsilon = [0.85 0.9 0.92];
users= [3 5 7];
lambda = [1 3];

mul = 0.1:0.01:1;

users_mul = 1:20;

av_age_normal = zeros(3, length(mul));
av_age_retr = zeros(3, length(mul));

for k = 1:3
    k;
    offset_users = zeros(10, 20);
    for i = 1:10
    %     epsilon_node(i) = (0.8-0.5).*rand(1, 1) + 0.5;
    %     epsilon_node(i) = 0.85;
        offset_users(i, :) = (0.5 - 0).*rand(1, 20) + 0;
    end

    epsilon_node = 0.9;

    % lambda_users = (3-0).*rand(10, num_users) + 0;
%     lambda_users = lambda(k)*ones(10, 20);



    max_retransmissions = 2;

    num_nodes = 2;
    num_users = users(k);

%     mu_node = num_users*higher;
    num_events = 3000;
    


    for j = 1 : length(mul)


        lambda_users = mul(j)*ones(10, 20);
        mul(j)
%         num_users = users_mul(j);
%         higher = lambda(k) + 1;
        mu_node = 1;
        num_events_considered = round(0.4*(num_users)*num_events);

        [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node_retr(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered, max_retransmissions);


        for i = 2:num_nodes
        %     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
            mu_node = 1;

            [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_node_retr(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :) ,mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices, max_retransmissions);
            final_arrival_times = arrival_times_out;
            departure_timestamps = departure_timestamps_out;
            ground_indices = ground_indices_out;
            largest_time = largest_time_out;
        end

        departure_timestamps_retr = departure_timestamps(ground_indices');
        ground_indices_retr = ground_indices;
        final_arrival_times_retr = final_arrival_times;


        [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users(1, :), offset_users(1, :), mu_node, epsilon_node, num_events, num_events_considered);


        for i = 2:num_nodes
        %     lambda_users = (0.4-0.1).*rand(1, num_users) + 0.1;
            mu_node = 1;

            [arrival_times_out, delay, arrival_timestamps_all, departure_timestamps_out, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users(i, :), offset_users(i, :) ,mu_node, epsilon_node, largest_time, final_arrival_times, ground_indices);
            final_arrival_times = arrival_times_out;
            departure_timestamps = departure_timestamps_out;
            ground_indices = ground_indices_out;
            largest_time = largest_time_out;
        end

        departure_timestamps = departure_timestamps(ground_indices');
        times = common_scale(departure_timestamps_retr, departure_timestamps);

        av_age_normal(k, j) = av_age_func(departure_timestamps, final_arrival_times, times);
        av_age_retr(k, j) = av_age_func(departure_timestamps_retr, final_arrival_times_retr, times);

    end

end
figure
plot(users_mul, av_age_retr(1, :), 'b', 'linestyle', 'none','marker', 's', 'markersize', 2, 'linewidth', 1); hold on;
plot(users_mul, av_age_normal(1, :),  'r', 'linestyle', 'none','marker', 's', 'markersize', 2, 'linewidth', 1); hold on;
plot(users_mul, av_age_retr(2, :), 'g', 'linestyle', 'none','marker', 's', 'markersize', 2, 'linewidth', 1); hold on;
plot(users_mul, av_age_normal(2, :),  'k', 'linestyle', 'none','marker', 's', 'markersize', 2, 'linewidth', 1); hold on;
plot(users_mul, av_age_retr(3, :), 'c', 'linestyle', 'none','marker', 's', 'markersize', 2, 'linewidth', 1); hold on;
plot(users_mul, av_age_normal(3, :),  'm', 'linestyle', 'none','marker', 's', 'markersize', 2, 'linewidth', 1); 
% plot(users_mul, av_age_retr(4, :), 'g', 'linestyle', 'none','marker', 'd', 'markersize', 2, 'linewidth', 1); hold on;
% plot(users_mul, av_age_normal(4, :),  'g', 'linestyle', 'none','marker', 'd', 'markersize', 2, 'linewidth', 1); hold on;
% plot(users_mul, av_age_retr(5, :), 'k', 'linestyle', 'none','marker', 'd', 'markersize', 2, 'linewidth', 1); hold on;
% plot(users_mul, av_age_normal(5, :),  'k', 'linestyle', 'none','marker', 'd', 'markersize', 2, 'linewidth', 1); 
% plot(users_mul, av_age_retr(6, :), 'm', 'linestyle', 'none','marker', 'd', 'markersize', 2, 'linewidth', 1); hold on;
% plot(users_mul, av_age_normal(6, :),  'm', 'linestyle', 'none','marker', 'd', 'markersize', 2, 'linewidth', 1); 
% plot(users_mul, av_age_retr(7, :), 'b', 'linestyle', 'none','marker', 'd', 'markersize', 2, 'linewidth', 1); hold on;
% plot(users_mul, av_age_normal(7, :),  'b', 'linestyle', 'none','marker', 'd', 'markersize', 2, 'linewidth', 1); 
legend('With Re-transmission', 'Without Re-transmission'); xlabel('Times'); ylabel('AoI'); 
grid on;











    


