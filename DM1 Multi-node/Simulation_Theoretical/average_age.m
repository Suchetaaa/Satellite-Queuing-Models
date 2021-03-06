%Gives simulated average age for a single node
function av_age = average_age(lambda_node, num_events)
    num_users = 1; 
    % num_events = 10;
    num_events_considered = 0.4*num_users*num_events;
    mu_node = 1;

    offset_start = (1-0).*rand(num_users, 1) + 0;
    % arrival_periods = (4-1).*rand(num_users, 1) + 1;
    num_events_matrix = 1:num_events;

    %Arrival timestamps sorted
    arrival_timestamps_unsorted =  offset_start + (1./lambda_node)*num_events_matrix ;
    arrival_timestamps = sort(arrival_timestamps_unsorted(:));
    final_arrival_times = arrival_timestamps(1:num_events_considered)';
    
    offset = min(arrival_timestamps);

    %Generates inter-service times
    inter_service_times = 1/mu_node*log(1./rand(1,num_events_considered));

    server_timestamps = zeros(1, num_events_considered);
    departure_timestamps = zeros(1, num_events_considered);

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

    %Times array used as the x-axis and for computing the AverageAoI
    times = 0:0.1:departure_timestamps(1);
    for i = 2:num_events_considered
        dummy = departure_timestamps(i-1):0.1:departure_timestamps(i);
        times = [times dummy];
    end

    %Computes age at every time instant
    j = 1;
    offset = 0;
    age = times;

    for i = 1 : length(times)
        if (times(i) == departure_timestamps(j))
            offset = final_arrival_times(j);
            j = j + 1;
        end
        age(i) = age(i) - offset;
    end

    plot(times, age);
    
    %Finds the area of the age plot under time
    trapz(times, age)
    max(times)
    
    %Average age
    av_age = trapz(times, age)/max(times);
end


    
    






