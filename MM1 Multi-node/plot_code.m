num_users = 10;
lambda_users = abs(randn(1, num_users));
mu_node = 0.25;
epsilon_node = 1;
num_events = 500;
num_events_considered = 0.4*(num_users)*num_events;

[departure_timestamps, waiting_times, buffer_lengths] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);

a = 0:0.5:departure_timestamps(num_events_considered);
a = a';
subplot(2, 2, 1)
plot(a, buffer_lengths);
title("events=0.4")

% mu_node = 0.5;
% num_users = 20;
% num_events_considered = 0.4*(num_users)*num_events;
% lambda_users = abs(randn(1, num_users));
% lambda_users = lambda_users + 0.1;
num_events_considered = 0.6*(num_users)*num_events;

[departure_timestamps, waiting_times, buffer_lengths] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);

a = 0:0.5:departure_timestamps(num_events_considered);
a = a';
subplot(2, 2, 2)
plot(a, buffer_lengths);
title("events=0.6")

% mu_node = 0.75;
% num_users = 30;
% num_events_considered = 0.4*(num_users)*num_events;
% lambda_users = abs(randn(1, num_users));
% lambda_users = lambda_users + 0.1;
num_events_considered = 0.8*(num_users)*num_events;

[departure_timestamps, waiting_times, buffer_lengths] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);

a = 0:0.5:departure_timestamps(num_events_considered);
a = a';
subplot(2, 2, 3)
plot(a, buffer_lengths);
title("events=0.8")

% mu_node = 1;
% num_users = 40;
% num_events_considered = 0.4*(num_users)*num_events;
% lambda_users = abs(randn(1, num_users));
% lambda_users = lambda_users + 0.1;
num_events_considered = 1*(num_users)*num_events;

[departure_timestamps, waiting_times, buffer_lengths] = first_node(num_users, lambda_users, mu_node, epsilon_node, num_events, num_events_considered);

a = 0:0.5:departure_timestamps(num_events_considered);
a = a';
subplot(2, 2, 4)
plot(a, buffer_lengths);
title("events=1")
