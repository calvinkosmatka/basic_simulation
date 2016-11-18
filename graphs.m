clear;

method = @inferenceAverage6;
numSim = 200000;
L = 150;
idealAlpha = derivedAlpha(method);

%method2 = @inferenceMajority6;
%idealAlpha2 = derivedAlpha(method2);

start = 0;
stop = .3;
step = .01;

size = floor((stop - start)/step)+1;
a = zeros(1, size);
b = zeros(1, size);
c = zeros(1, size);

count = 1;

for t = start:step:stop
    a(count) = t;
    b(count) = calcAlpha6(method, numSim, t, L);
    %b(count) = idealAlpha2(t);
    c(count) = idealAlpha(t);
    count = count + 1;
end
plot(a,b,'r+', a, c, 'b+');