%Represents the first node for with re-transmissions = 2
function [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node_retr_2(num_users, lambda_users, offset_users, mu_node, epsilon_node, num_events, num_events_considered, max_retransmissions)
    
    event_times_users = zeros(num_users, num_events);
    num_events_matrix = 1:num_events;

    %Deterministic or Periodic Arrivals
    for i = 1:num_users
        event_times_users(i, :) = offset_users(i) + (1./lambda_users(1, i))*num_events_matrix ;
    end
    
    %Comment this out to get poisson arrivals 
%     for i = 1:num_users
%         inter_event_times = 1/lambda_users(1, i)*log(1./rand(1,num_events));
%         event_times_users(i, :) = cumsum(inter_event_times);
%     end
    
    offset = min(event_times_users(:, 1));

    %Sorting the arrivals times obtained from various users
    final_arrival_times = sort(event_times_users(:));
    final_arrival_times = final_arrival_times(1:num_events_considered);

    %Inter-service times
    inter_service_times = 1/mu_node*log(1./rand(1,(max_retransmissions + 1)*num_events_considered));

    server_timestamps = zeros(1, num_events_considered);
    departure_timestamps = zeros(1, num_events_considered);
    
    %Keeps track of the number of retransmissions required for that packet
    retransmissions = zeros(1, num_events_considered);
    
    %1 means the packet is missed, 0 means it is transmitted
    missed = zeros(1, num_events_considered);
    
    random_indices_1_useful = rand(1, num_events_considered) > epsilon_node;
    %random_indices_1 holds 0 and 1, 1 means retransmission is required
    random_indices_1 = find(random_indices_1_useful == 1);
    number = length(random_indices_1);
    random_indices_2_useful = rand(1, number) > epsilon_node;
    %1 means second retransmission is required, 0 means only the first
    %retransmission
    random_indices_2 = find(random_indices_2_useful == 1);
    number_2 = length(random_indices_2);
    %1 means transmission cannot occur, 0 means only the second
    %retransmission
    random_indices_3 = rand(1, number_2) > epsilon_node;

    for i = 1 : number_2 
        if (random_indices_3(i) == 1)
            missed(random_indices_1(random_indices_2(i))) = 1;
        end
    end
            
    for i = 1:number
        if (random_indices_2_useful(i) == 1)
            retransmissions(1, random_indices_1(i)) = 2;
        else
            retransmissions(1, random_indices_1(i)) = 1;
        end
    end

    %Assigning departure timestamps tp the packets
    server_timestamps(1) = offset;
    index_missing = 1;

    if (retransmissions(1) == 2)
        departure_timestamps(1) = server_timestamps(1) + inter_service_times(1) + inter_service_times(2) + inter_service_times(3);
        index_missing = index_missing + 2;
    elseif (retransmissions(1) == 1)
        departure_timestamps(1) = server_timestamps(1) + inter_service_times(1) + inter_service_times(2);
        index_missing = index_missing + 1;
    else
        departure_timestamps(1) = server_timestamps(1) + inter_service_times(1);
    end
    

    for i = 2:num_events_considered
        if (retransmissions(i) == 2)
            if final_arrival_times(i) < departure_timestamps(i-1)
                server_timestamps(i) = departure_timestamps(i-1);
            else
                server_timestamps(i) = final_arrival_times(i);
            end
            departure_timestamps(i) = server_timestamps(i) + inter_service_times(i+index_missing-1) + inter_service_times(i+index_missing) + inter_service_times(i+index_missing+1);
            index_missing = index_missing + 2;
        elseif (retransmissions(i) == 1)
            if final_arrival_times(i) < departure_timestamps(i-1)
                server_timestamps(i) = departure_timestamps(i-1);
            else
                server_timestamps(i) = final_arrival_times(i);
            end
            departure_timestamps(i) = server_timestamps(i) + inter_service_times(i+index_missing-1) + inter_service_times(i+index_missing);
            index_missing = index_missing + 1;
        else
            if final_arrival_times(i) < departure_timestamps(i-1)
                server_timestamps(i) = departure_timestamps(i-1);
            else
                server_timestamps(i) = final_arrival_times(i);
            end
            departure_timestamps(i) = server_timestamps(i) + inter_service_times(i+index_missing-1);
        end
    end
    
    %Buffer Lengths vs time for the present node
    times = 0:0.5:departure_timestamps(num_events_considered);
    buffer_lengths = zeros(length(times), 1);
    for i = 1:length(times)
        a = final_arrival_times <= times(i);
        num_arrivals = numel(a(a>0));
        b = departure_timestamps < times(i);
        num_departures = numel(b(b>0));
        buffer_lengths(i, 1) = (num_arrivals-num_departures);
    end
    
    waiting_times = (departure_timestamps - final_arrival_times);
    
    %Random indices are basically the indices which are not transmitted
    random_indices = find(missed == 1);
    
    %Updating the departure and arrival timestamps
    departure_timestamps(random_indices) = [];
    final_arrival_times(random_indices) = [];
    
    largest_time = max(departure_timestamps);
    
    [~, m] = size(departure_timestamps);
    ground_indices = 1:m;
end

    

