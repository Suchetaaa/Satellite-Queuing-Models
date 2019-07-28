%Used to create a common time scale given two departure timestamps
function [times] = common_scale(departure_timestamps_retransmission, departure_timestamps)
	common_departures = [departure_timestamps_retransmission departure_timestamps];
	common_departures = sort(common_departures(:));
	times = 0:0.1:common_departures(1)
	[~, num_events] = size(common_departures);
    for i = 2:num_events
        dummy = common_departures(i-1):0.1:common_departures(i);
        times = [times dummy];
    end 
end