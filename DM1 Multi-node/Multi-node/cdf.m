%Computes the CDF - Cumulative Distribution Function
function [cdf_out, delay_sorted] = cdf(delay_end2end)
    delay_sorted = sort(delay_end2end);
    [~ ,m] = size(delay_sorted);
    cdf_out = 1:m;
    cdf_out = cdf_out./m;
end