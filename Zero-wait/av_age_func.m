%Computes the average AoI given departure timestamps and arrival times
function [av_age] = av_age_func(departure_timestamps, final_arrival_times)
    
    %Generates times for the time axis
    times = 0:0.1:departure_timestamps(1);
    [~, num_events] = size(departure_timestamps);
    for i = 2:num_events
        dummy = departure_timestamps(i-1):0.1:departure_timestamps(i);
        times = [times dummy];
    end

    %Computes the age for evry time instant
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

%     plot(times, age);

    trapz(times, age);
    max(times);
    
    %Average AoI
    av_age = trapz(times, age)/max(times);
end