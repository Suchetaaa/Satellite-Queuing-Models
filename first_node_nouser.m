function [arrival_times_final, arrival_times_in] = first_node_nouser(lambda_node, mu_node, num_events)

inter_event_times = 1/lambda_node*log(1./rand(1,num_events));
inter_service_times = 1/mu_node*log(1./rand(1,num_events));



end