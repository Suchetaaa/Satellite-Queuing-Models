num_users = [2 3 5];

mu = num_users(3) + 1:0.5:5*num_users(3);
av_age = zeros(3, length(mu));

for j = 1:3
    

    for k = 1 : length(mu)
        num_nodes = 1;

        for i = 1:10
        %     epsilon_node(i) = (0.8-0.5).*rand(1, 1) + 0.5;
            epsilon_node(i) = 0.9;
        end

        %     lambda_users = (0.4-0.1).*rand(10, num_users) + 0.1;
        lambda_users = ones(1, num_users(j));
        mu_node = mu(k);
        num_events = 5000;
        num_events_considered = round(0.4*(num_users(j))*num_events);

        [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users(j), lambda_users(1, :), mu_node, epsilon_node(1), num_events, num_events_considered);

        av_age(j, k) = av_age_func(departure_timestamps, final_arrival_times, length(departure_timestamps));

    end
end

    plot(mu, av_age(1, :), 'b', 'linestyle', 'none','marker', '*', 'markersize', 3, 'linewidth', 1); hold on;
    plot(mu, av_age(2, :), 'g', 'linestyle', 'none','marker', '*', 'markersize', 3, 'linewidth', 1); hold on;
    plot(mu, av_age(3, :), 'r', 'linestyle', 'none','marker', '*', 'markersize', 3, 'linewidth', 1); 
    legend('Users = 2', 'Users= 3', 'Users = 5'); xlabel('Mu'); ylabel('AoI');