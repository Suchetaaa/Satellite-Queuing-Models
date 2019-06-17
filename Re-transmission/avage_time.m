function [av_age, age] = avage_time(departure_timestamps, final_arrival_times, times)
    j = 1;
    offset = 0;
    age = times;

    for i = 1 : length(times)
        if (times(i) == departure_timestamps(j))
            offset = final_arrival_times(j);
            j = j + 1;
            if (j == length(departure_timestamps))
                j = j - 1;
            end
        end
        age(i) = age(i) - offset;
    end
    
    length(times);
    plot(times, age);

    av_age = zeros(1, length(age));
    for i = 2 : length(times)
        dummy_time = times(1, 1:i);
        dummy_age = age(1, 1:i);
        i;
        av_age(i) = trapz(dummy_time, dummy_age);
    end

    %plot(times, av_age);
end