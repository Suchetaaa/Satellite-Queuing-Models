%Represents every other node apart from the first node with 0
%retransmissions
function [arrival_times_in, delay, arrival_timestamps_all, departure_timestamps_out_1, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_nodes_retr_0(departure_timestamps, num_users, lambda_users, offset_users, mu_node, epsilon_node, largest_time, arrival_times_in, ground_indices_in)
    %Generates arrival times of the intermediate traffic taking into
    %account the 'largest time' coming from the previous time
    done = 0;
    j = 0;

    while done == 0
        j = j+1;
        event_times_users = zeros(num_users, j);
        for i = 1:num_users
            num_events_matrix = 1:j;
            event_times_users(i, :) = offset_users(i) + (1./lambda_users(i))*num_events_matrix ;
        end
        
        if (min(event_times_users(:, j)) > largest_time)
            done = 1;
        end
    end
    
    %Incorporates intermediate and incoming traffic and sorts them
    arrival_timestamps_all = sort(event_times_users(:));
    arrival_timestamps_all = arrival_timestamps_all';
    
    new = [departure_timestamps arrival_timestamps_all];
    arrival_timestamps_all = sort(new(:));
    
    %Extracts only the useful indices
    a = arrival_timestamps_all <= largest_time;
    num_useful = numel(a(a>0));
    arrival_timestamps_all = arrival_timestamps_all(1:num_useful, 1)';
    
    offset = arrival_timestamps_all(1);
    
    [~, m] = size(ground_indices_in);
    ground_indices = zeros(1, m);
    
    %Re-computing the ground indices after incorporating intermediate
    %traffic
    for k = 1 : m
        ground_indices(1, k) = find(arrival_timestamps_all == departure_timestamps(1, ground_indices_in(1, k)));
    end
     
    server_timestamps = zeros(1, num_useful);
    departure_timestamps_out = zeros(1, num_useful);
    
    %Inter-service times
    inter_service_times = 1/mu_node*log(1./rand(1,num_useful));
    
    %Assigning the departure timestamps to packets
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
    
    %Buffer Lengths vs Time for the present node
    times = 0:0.5:departure_timestamps_out(num_useful);
    buffer_lengths = zeros(length(times), 1);
    for i = 1:length(times)
        a = arrival_timestamps_all <= times(i);
        num_arrivals = numel(a(a>0));
        b = departure_timestamps_out < times(i);
        num_departures = numel(b(b>0));
        buffer_lengths(i, 1) = (num_arrivals-num_departures);
    end
    
    waiting_times = (departure_timestamps_out - arrival_timestamps_all(1, 1:num_useful));
    
    for i = 1 : m
        delay = (departure_timestamps_out(ground_indices') - arrival_times_in');
    end
    
    %Random indices - 0 means that the packet is transmitted, 1 means
    %cannot be transmitted
    random_indices = rand(1, num_useful) > epsilon_node;
    random_indices = find(random_indices == 1);
    departure_timestamps_out_1 = departure_timestamps_out;
    departure_timestamps_out_1(random_indices) = [];
   
    %Checking if any of the ground indices are also present in random
    %indices and necessary actions 
    l = 0;
    for k = 1 : m
        a = find(random_indices == ground_indices(1, k)); 
        if (a ~= 0)
            l = l + 1;
            unwanted_indices(1, l) = k;
        end
    end
    
    ground_indices(unwanted_indices) = [];
    arrival_times_in(unwanted_indices) = [];
    
    %Final ground indices which are returned 
    for k = 1 : m-l
        ground_indices_out(1, k) = find(departure_timestamps_out_1 == departure_timestamps_out(1, ground_indices(1, k)));
    end
        
    largest_time_out = max(departure_timestamps_out_1); 
end
    