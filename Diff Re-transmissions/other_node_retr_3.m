%Represents every other node apart from the first node with 3
%retransmissions
function [arrival_times_in, delay, arrival_timestamps_all, departure_timestamps_out_1, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_node_retr_3(departure_timestamps, num_users, lambda_users, offset_users, mu_node, epsilon_node, largest_time, arrival_times_in, ground_indices_in, max_retransmissions)
    %Generates arrival times of the intermediate traffic taking into
    %account the 'largest time' coming from the previous time
    done = 0;
    j = 0;

    while done == 0
        j = j+1;
        
        %For periodic and deterministic arrivals
        event_times_users = zeros(num_users, j);
        for i = 1:num_users
            num_events_matrix = 1:j;
            event_times_users(i, :) = offset_users(i) + (1./lambda_users(i))*num_events_matrix ;
        end
        
        %Comment this out to get poisson arrivals
%         for i = 1:num_users
%             inter_event_times(i, j) = 1/lambda_users(1, i)*log(1./rand(1,1));
%             event_times_users(i, :) = cumsum(inter_event_times(i, :));
%         end
        
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
    inter_service_times = 1/mu_node*log(1./rand(1,(max_retransmissions+1)*num_useful));
    
    %Keeps track of the number of retransmissions required for that packet
    retransmissions = zeros(1, num_useful);
    
    %1 means the packet is missed, 0 means it is transmitted
    missed = zeros(1, num_useful);
    
    random_indices_1_useful = rand(1, num_useful) > epsilon_node;
    
    %Contains all the indices which require the first retransmission
    random_indices_1 = find(random_indices_1_useful == 1);
    number = length(random_indices_1);
    random_indices_2_useful = rand(1, number) > epsilon_node;
    
    %Contains all those indices which require the second retransmission
    random_indices_2 = find(random_indices_2_useful == 1);
    number_2 = length(random_indices_2);
    random_indices_3_useful = rand(1, number_2) > epsilon_node;
    
    %contains all those indices which require the third retransmission
    random_indices_3 = find(random_indices_3_useful == 1);
    number_3 = length(random_indices_3);
    
    %1 means transmission cannot occur, 0 means 1 retransmission
    random_indices_4 = rand(1, number_3) > epsilon_node;

    for i = 1 : number_3
        if (random_indices_4(i) == 1)
            missed(random_indices_1(random_indices_2(random_indices_3(i)))) = 1;
        end
    end
    
    random_indices_3_actual = zeros(1, number_3);
    random_indices_2_actual = zeros(1, number_2);
    
    for i = 1:number_3
        %Contains the actual indices from the (1: num_useful) which require 3 retransmissions
        random_indices_3_actual(i) = random_indices_1(random_indices_2(random_indices_3(i)));
        retransmissions(1, random_indices_1(random_indices_2(random_indices_3(i)))) = 3;     
    end
    
    for i = 1:number_2
        random_indices_2_actual(i) = random_indices_1(random_indices_2(i));
    end
    
    %Contains the actual indices from the (1: num_useful) which require 2 retransmissions
    retransmissions_2_indices = setdiff(random_indices_2_actual, random_indices_3_actual);
    
    %Contains the actual indices from the (1: num_useful) which require 1 retransmissions
    retransmissions_1_indices = setdiff(random_indices_1, random_indices_2_actual);
    
    retransmissions(retransmissions_2_indices) = 2;
    retransmissions(retransmissions_1_indices) = 1;
    
    %Assigning the departure timestamps to packets
    server_timestamps(1) = offset;
    index_missing = 1;

    if (retransmissions(1) == 3)
        departure_timestamps(1) = server_timestamps(1) + inter_service_times(1) + inter_service_times(2) + inter_service_times(3) + inter_service_times(4);
        index_missing = index_missing + 3;
    elseif (retransmissions(1) == 2)
        departure_timestamps(1) = server_timestamps(1) + inter_service_times(1) + inter_service_times(2) + inter_service_times(3);
        index_missing = index_missing + 2;
    elseif (retransmissions(1) == 1)
        departure_timestamps(1) = server_timestamps(1) + inter_service_times(1) + inter_service_times(2);
        index_missing = index_missing + 1;
    else
        departure_timestamps(1) = server_timestamps(1) + inter_service_times(1);
    end
    

    for i = 2:num_useful
        if (retransmissions(i) == 3)
            if arrival_timestamps_all(i) < departure_timestamps(i-1)
                server_timestamps(i) = departure_timestamps(i-1);
            else
                server_timestamps(i) = arrival_timestamps_all(i);
            end
            departure_timestamps(i) = server_timestamps(i) + inter_service_times(i+index_missing-1) + inter_service_times(i+index_missing) + inter_service_times(i+index_missing+1) + inter_service_times(i+index_missing+2);
            index_missing = index_missing + 3;
        elseif (retransmissions(i) == 2)
            if arrival_timestamps_all(i) < departure_timestamps(i-1)
                server_timestamps(i) = departure_timestamps(i-1);
            else
                server_timestamps(i) = arrival_timestamps_all(i);
            end
            departure_timestamps(i) = server_timestamps(i) + inter_service_times(i+index_missing-1) + inter_service_times(i+index_missing) + inter_service_times(i+index_missing+1);
            index_missing = index_missing + 2;
        elseif (retransmissions(i) == 1)
            if arrival_timestamps_all(i) < departure_timestamps(i-1)
                server_timestamps(i) = departure_timestamps(i-1);
            else
                server_timestamps(i) = arrival_timestamps_all(i);
            end
            departure_timestamps(i) = server_timestamps(i) + inter_service_times(i+index_missing-1) + inter_service_times(i+index_missing);
            index_missing = index_missing + 1;
        else
            if arrival_timestamps_all(i) < departure_timestamps(i-1)
                server_timestamps(i) = departure_timestamps(i-1);
            else
                server_timestamps(i) = arrival_timestamps_all(i);
            end
            departure_timestamps(i) = server_timestamps(i) + inter_service_times(i+index_missing-1);
        end
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
    departure_timestamps_out = departure_timestamps;
    waiting_times = (departure_timestamps_out - arrival_timestamps_all(1, 1:num_useful));
    
    for i = 1 : m
        delay = (departure_timestamps_out(ground_indices') - arrival_times_in');
    end
        
    %Random indices are basically the indices which are not transmitted
    random_indices = find(missed == 1);
    departure_timestamps_out_1 = departure_timestamps_out;
    
    %Updating the departure timestamps
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
    
    if (l ~= 0)
        ground_indices(unwanted_indices) = [];
        arrival_times_in(unwanted_indices) = [];
    end
    
    %Final ground indices which are returned
    for k = 1 : m-l
        ground_indices_out(1, k) = find(departure_timestamps_out_1 == departure_timestamps_out(1, ground_indices(1, k)));
    end
    
    largest_time_out = max(departure_timestamps_out_1); 
end
    