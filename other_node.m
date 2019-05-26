function [arrival_timestamps_all_1] = other_node(departure_timestamps, num_users, lambda_users, mu_node, epsilon_node, last_index)
%     num_users = 10;
%     lambda_users = abs(randn(1, num_users));
%     mu_node = 1;
%     epsilon_node = 0.6;

    done = 0;
    j = 1;

    while done == 0
        event_times_users = zeros(num_users, j);
        for i = 1:num_users
            inter_event_times(i, j) = 1/lambda_users(1, i)*log(1./rand(1,1));
            event_times_users(i, :) = cumsum(inter_event_times(i, :));
        end
        
        if (min(event_times_users(:, j)) > departure_timestamps(last_index, 1))
            done = 1;
        end
        j = j+1
%         event_times_users;
    end
    
    arrival_timestamps_all = sort(event_times_users(:));
    new = [departure_timestamps; arrival_timestamps_all];
    arrival_timestamps_all = sort(new(:));

    
end
    