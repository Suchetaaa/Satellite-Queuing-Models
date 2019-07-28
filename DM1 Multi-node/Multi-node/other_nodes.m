function [arrival_times_in, delay, arrival_timestamps_all, departure_timestamps_out_1, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes(departure_timestamps, num_users, lambda_users, offset_users, mu_node, epsilon_node, largest_time, arrival_times_in, ground_indices_in)

    % Generates many arrival timestamps of the intermediate traffic taking
    % into account the traffic coming from previous node (largest_time)
    done = 0;
    j = 0;

    while done == 0
        j = j+1;
        event_times_users = zeros(num_users, j);
        
        %Periodic or Deterministic traffic
        for i = 1:num_users
            num_events_matrix = 1:j;
            event_times_users(i, :) = offset_users(i) + (1./lambda_users(i))*num_events_matrix ;
        end
        
        if (min(event_times_users(:, j)) > largest_time)
            done = 1;
        end
    end
    
    %Sorting all the arrival-timestamps (intermediate and incoming traffic)
    arrival_timestamps_all = sort(event_times_users(:));
    arrival_timestamps_all = arrival_timestamps_all';
    
    new = [departure_timestamps arrival_timestamps_all];
    arrival_timestamps_all = sort(new(:));
    
    %Taking only the useful indices
    a = arrival_timestamps_all <= largest_time;
    num_useful = numel(a(a>0));
    arrival_timestamps_all = arrival_timestamps_all(1:num_useful, 1)';
    
    offset = arrival_timestamps_all(1);
    
    [~, m] = size(ground_indices_in);
    ground_indices = zeros(1, m);
    
    %Finding the changed ground_indices
    for k = 1 : m
        ground_indices(1, k) = find(arrival_timestamps_all == departure_timestamps(1, ground_indices_in(1, k)));
    end
     
    %Assigning departure timestamps for all the packets
    server_timestamps = zeros(1, num_useful);
    departure_timestamps_out = zeros(1, num_useful);
    
    inter_service_times = 1/mu_node*log(1./rand(1,num_useful));
    
    server_timestamps(1) = offset;
    departure_timestamps_out(1) = server_timestamps(1) + inter_service_times(1);
    
    for i = 2:num_useful
        if arrival_timestamps_all(i) < departure_timestamps_out(i-1)
            server_timestamps(i) = departure_timestamps_out(i-1);
        else
            server_timestamps(i) = arrival_timestamps_all(i);
        end   
       departure_timestamps_out(i) = server_timestamps(i) + inter_service_times(i);   
    end
    
    %Computes buffer lengths
    times = 0:0.5:departure_timestamps_out(num_useful);
    buffer_lengths = zeros(length(times), 1);
    for i = 1:length(times)
        a = arrival_timestamps_all <= times(i);
        num_arrivals = numel(a(a>0));
        b = departure_timestamps_out < times(i);
        num_departures = numel(b(b>0));
        buffer_lengths(i, 1) = (num_arrivals-num_departures);
    end
    
    %Waiting times
    waiting_times = (departure_timestamps_out - arrival_timestamps_all(1, 1:num_useful));
    
    %Computed the delay of ONLY the ground indices
    for i = 1 : m
        delay = (departure_timestamps_out(ground_indices') - arrival_times_in');
    end
    
    %Removes some indices as a part of the reliability
    random_indices = randperm(num_useful, round((1-epsilon_node)*num_useful));
    departure_timestamps_out_1 = departure_timestamps_out;
    departure_timestamps_out_1(random_indices) = [];
   
    %Checks if any ground_indices are removed and makes changes accordingly
    l = 0;
    for k = 1 : m
%         ground_indices(1, k)
        a = find(random_indices == ground_indices(1, k)); 
        if (a ~= 0)
            l = l + 1;
            unwanted_indices(1, l) = k;
        end
    end
    
    ground_indices(unwanted_indices) = []; 
    arrival_times_in(unwanted_indices) = [];
    
    %Final ground_indices that are returned from the function
    for k = 1 : m-l
        ground_indices_out(1, k) = find(departure_timestamps_out_1 == departure_timestamps_out(1, ground_indices(1, k)));
    end
        
    largest_time_out = max(departure_timestamps_out_1); 
end
    