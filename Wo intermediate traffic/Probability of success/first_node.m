%Represents the first node for NO retransmissions
function [ground_indices, final_arrival_times, departure_timestamps, waiting_times, buffer_lengths, largest_time] = first_node(num_users, lambda_users, offset_users, mu_node, epsilon_node, num_events, num_events_considered)
    
    event_times_users = zeros(num_users, num_events);
    num_events_matrix = 1:num_events;

    for i = 1:num_users
        
        %Poisson arrivals
        inter_event_times = 1/lambda_users(1, i)*log(1./rand(1,num_events));
        event_times_users(i, :) = cumsum(inter_event_times);
        
        %Comment this out for periodic arrivals
%         event_times_users(i, :) = offset_users(i) + (1./lambda_users(i))*num_events_matrix ;
    end
    
    offset = min(event_times_users(:, 1));

    %Sorting the arrivals times obtained from various users
    final_arrival_times = sort(event_times_users(:));
    final_arrival_times = final_arrival_times(1:num_events_considered);

    %Inter-service times
    inter_service_times = 1/mu_node*log(1./rand(1,num_events_considered));

    server_timestamps = zeros(1, num_events_considered);
    departure_timestamps = zeros(1, num_events_considered);
    
    packets_out_theoretical = 0.9*num_events_considered;

    %Assigning departure timestamps to the packets
    server_timestamps(1) = offset;
    departure_timestamps(1) = server_timestamps(1) + inter_service_times(1);

    for i = 2:num_events_considered
        if final_arrival_times(i) < departure_timestamps(i-1)
            server_timestamps(i) = departure_timestamps(i-1);
        else
            server_timestamps(i) = final_arrival_times(i);
        end
        departure_timestamps(i) = server_timestamps(i) + inter_service_times(i);
    end
    
    %Buffer lengths vs time for the present node
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
    random_indices = randperm(num_events_considered, round((1-epsilon_node)*num_events_considered));
    
    %Updating the departure and arrival timestamps
    departure_timestamps(random_indices) = [];
    final_arrival_times(random_indices) = [];
    
    packets_out_sim = length(departure_timestamps);
    
    largest_time = departure_timestamps(packets_out_sim);
    
    [~, m] = size(departure_timestamps);
    ground_indices = 1:m;
end

    

