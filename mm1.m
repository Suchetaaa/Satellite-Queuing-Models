function [sojourntime]=mm1(lambda,mu,sizev)

intera =1/lambda*log(1./rand(1,sizev));
service=1/mu*log(1./rand(1,sizev));

% Times of arrival, server (leaving the queue) and departure (leaving the
% system
a = zeros(1, sizev);
s = zeros(1, sizev);
d = zeros(1, sizev);

a(1) = 0;
for i = 2:sizev
    a(i) = a(i-1) + intera(i-1);
end
s(1) = 0;
d(1) = s(1) + service(1);
for i = 2: sizev
    if a(i) < d(i-1)
        s(i) = d(i-1);
    else
        s(i) = a(i);
    end   
   d(i) = s(i) + service(i);   
end

sojourntime = mean(d-a);





