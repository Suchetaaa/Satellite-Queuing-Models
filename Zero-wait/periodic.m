%Returns simulated and theoretical average AoI for the periodic arrival
%tandem queue 
function [av_age_periodic_simulation, av_age_periodic_theoretical] = periodic(rho, lambda)
%Rho is basically defined as mu_node_1/mu_node_2 as given in the paper

    %Simulated average AoI
    av_age_periodic_simulation = zeros(1, length(rho));
    
    %Theoretical Average AoI
    av_age_periodic_theoretical = zeros(1, length(rho));
    
    %Generates theoretical and simulated average AoI
    for j = 1 : length(rho)

        mu_node_1 = rho(j);
        mu_node_2 = 1;

        num_events = 10000;
        
        %Generating periodic arrival timestamps 
        num_events_matrix = 1:num_events;
        arrival_timestamps = (1/lambda)*num_events_matrix;

        %Inter-service times of node 1
        inter_service_times_1 = 1/mu_node_1*log(1./rand(1,num_events));

        %Generating departure timestamps for the node 1
        server_timestamps_1 = zeros(1, num_events);
        departure_timestamps_1 = zeros(1, num_events);

        server_timestamps_1(1) = 0;
        departure_timestamps_1(1) = server_timestamps_1(1) + inter_service_times_1(1);

        for i = 2:num_events
            if arrival_timestamps(i) < departure_timestamps_1(i-1)
                server_timestamps_1(i) = departure_timestamps_1(i-1);
            else
                server_timestamps_1(i) = arrival_timestamps(i);
            end
            departure_timestamps_1(i) = server_timestamps_1(i) + inter_service_times_1(i);
        end

        %Inter-service times for the node 2
        inter_service_times_2 = 1/mu_node_2*log(1./rand(1, num_events));

        %Generating departure timestamps for the second node
        server_timestamps_2 = zeros(1, num_events);
        departure_timestamps_2 = zeros(1, num_events);

        server_timestamps_2(1) = departure_timestamps_1(1);
        departure_timestamps_2(1) = server_timestamps_2(1) + inter_service_times_2(1);

        for i = 2:num_events
            if departure_timestamps_1(i) < departure_timestamps_2(i-1)
                server_timestamps_2(i) = departure_timestamps_2(i-1);
            else
                server_timestamps_2(i) = departure_timestamps_1(i);
            end
            departure_timestamps_2(i) = server_timestamps_2(i) + inter_service_times_2(i);
        end

    av_age_periodic_simulation(1, j) = av_age_func(departure_timestamps_2, arrival_timestamps);
    av_age_periodic_theoretical(1, j) = 1 + 2/rho(j) + rho(j)*(2*(rho(j)^2) - rho(j) + 1)/((1 - rho(j))*(1 + rho(j)));

    end

end


