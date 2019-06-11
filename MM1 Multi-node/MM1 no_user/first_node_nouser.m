function [arrival_times_final, arrival_times_in] = first_node_nouser(lambda_node, mu_node, num_events)

    inter_event_times = 1/lambda_node*log(1./rand(1,num_events));
    inter_service_times = 1/mu_node*log(1./rand(1,num_events));
    
    final_arrival_times = cumsum(inter_event_times);
    offset = min(final_arrival_times);

    server_timestamps = zeros(1, num_events);
    departure_timestamps = zeros(1, num_events);

    server_timestamps(1) = offset;
    departure_timestamps(1) = server_timestamps(1) + inter_service_times(1);

    for i = 2:num_events
        if final_arrival_times(i) < departure_timestamps(i-1)
            server_timestamps(i) = departure_timestamps(i-1);
        else
            server_timestamps(i) = final_arrival_times(i);
        end
        departure_timestamps(i) = server_timestamps(i) + inter_service_times(i);
    end
    
    arrival_times_final = final_arrival_times;
    arrival_times_in = departure_timestamps;
    
end