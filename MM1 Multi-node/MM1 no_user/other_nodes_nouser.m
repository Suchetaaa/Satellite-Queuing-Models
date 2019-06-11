function [departure_timestamps_out, final_arrival_times] = other_nodes_nouser(arrival_times_in, arrival_times_final, mu_node)
    
    final_arrival_times = arrival_times_in;
    [~, m] = size(final_arrival_times);
    
    server_timestamps = zeros(1, m);
    departure_timestamps_out = zeros(1, m);

    inter_service_times = 1/mu_node*log(1./rand(1,m));

    server_timestamps(1) = min(final_arrival_times);
    departure_timestamps_out(1) = server_timestamps(1) + inter_service_times(1);

    for i = 2:m
        if final_arrival_times(i) < departure_timestamps_out(i-1)
            server_timestamps(i) = departure_timestamps_out(i-1);
        else
            server_timestamps(i) = final_arrival_times(i);
        end   
       departure_timestamps_out(i) = server_timestamps(i) + inter_service_times(i);   
    end
    
    final_arrival_times = arrival_times_final;
end