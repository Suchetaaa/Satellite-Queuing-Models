function [av_age] = av_age_func(departure_timestamps, final_arrival_times, times)
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

%     plot(times, age);

    trapz(times, age)
    max(times)
    av_age = trapz(times, age)/max(times);
end