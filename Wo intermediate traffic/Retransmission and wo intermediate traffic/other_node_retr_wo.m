%Represents the first node for with re-transmissions = 2 WITHOUT intermediate
%traffic
function [arrival_times_in, delay, arrival_timestamps_all, departure_timestamps_out_1, ground_indices_out, largest_time_out, buffer_lengths, waiting_times] = other_node_retr(departure_timestamps, mu_node, epsilon_node, largest_time, arrival_times_in, ground_indices_in, max_retransmissions)
    
    %Packets arriving from the previous node
    new = departure_timestamps;
    arrival_timestamps_all = sort(new(:));
    
    num_useful = length(departure_timestamps);
    arrival_timestamps_all = arrival_timestamps_all(1:num_useful, 1)';
    
    offset = arrival_timestamps_all(1);
    
    [~, m] = size(ground_indices_in);

    ground_indices = ground_indices_in;
     
    server_timestamps = zeros(1, num_useful);
    departure_timestamps_out = zeros(1, num_useful);
    
    %Inter-service times
    inter_service_times = 1/mu_node*log(1./rand(1,(max_retransmissions+1)*num_useful));
    
    %Keeps track of the number of retransmissions required for that packet
    retransmissions = zeros(1, num_useful);
    
    %1 means the packet is missed, 0 means it is transmitted
    missed = zeros(1, num_useful);
    
    %Contains all the indices which require the first retransmission
    random_indices_1_useful = rand(1, num_useful) > epsilon_node;
    random_indices_1 = find(random_indices_1_useful == 1);
    number = length(random_indices_1);
    
    %Contains all the indices which require the first retransmission
    random_indices_2_useful = rand(1, number) > epsilon_node;
    random_indices_2 = find(random_indices_2_useful == 1);
    number_2 = length(random_indices_2);
    
    %1 means transmission cannot occur, 0 means 2 retransmissions
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

    index_missing = 1;

    if (retransmissions(1) == 2)
        server_timestamps(1) = offset;
        departure_timestamps_out(1) = server_timestamps(1) + inter_service_times(1) + inter_service_times(2) + inter_service_times(3);
        index_missing = index_missing + 2;
    elseif (retransmissions(1) == 1)
        server_timestamps(1) = offset;
        departure_timestamps_out(1) = server_timestamps(1) + inter_service_times(1) + inter_service_times(2);
        index_missing = index_missing + 1;
    else
        server_timestamps(1) = offset;
        departure_timestamps_out(1) = server_timestamps(1) + inter_service_times(1);
    end
    
    

    for i = 2:num_useful
        if (retransmissions(i) == 2)
            if arrival_timestamps_all(i) < departure_timestamps_out(i-1)
                server_timestamps(i) = departure_timestamps_out(i-1);
            else
                server_timestamps(i) = arrival_timestamps_all(i);
            end
            departure_timestamps_out(i) = server_timestamps(i) + inter_service_times(i+index_missing-1) + inter_service_times(i+index_missing) + inter_service_times(i+index_missing+1);
            index_missing = index_missing + 2;
        elseif (retransmissions(i) == 1)
            if arrival_timestamps_all(i) < departure_timestamps_out(i-1)
                server_timestamps(i) = departure_timestamps_out(i-1);
            else
                server_timestamps(i) = arrival_timestamps_all(i);
            end
            departure_timestamps_out(i) = server_timestamps(i) + inter_service_times(i+index_missing-1) + inter_service_times(i+index_missing);
            index_missing = index_missing + 1;
        else
            if arrival_timestamps_all(i) < departure_timestamps_out(i-1)
                server_timestamps(i) = departure_timestamps_out(i-1);
            else
                server_timestamps(i) = arrival_timestamps_all(i);
            end
            departure_timestamps_out(i) = server_timestamps(i) + inter_service_times(i+index_missing-1);
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
    
    waiting_times = (departure_timestamps_out - arrival_timestamps_all(1, 1:num_useful));
    
    for i = 1 : m
        delay = (departure_timestamps_out(ground_indices') - arrival_times_in');
    end
        
    %Random indices are basically the indices which are not transmitted
    random_indices = find(missed == 1);
    departure_timestamps_out_1 = departure_timestamps_out;
    departure_timestamps_out_1(random_indices) = [];
   
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
    
    %Updating the ground indices which are to be returned
    for k = 1 : m-l
        ground_indices_out(1, k) = find(departure_timestamps_out_1 == departure_timestamps_out(1, ground_indices(1, k)));
    end
    
    largest_time_out = max(departure_timestamps_out_1); 
end
    