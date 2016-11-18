clear;

method = @inferenceAverage6;
numSim = 100;
L = 100;

start2 = 0;
stop2 = 2;
step2 = 0.5;

start1 = 0;
stop1 = 100;
step1 = 10;

size1 = floor((stop1 - start1)/step1)+1;
size2 = floor((stop2 - start2)/step2)+1;
a = zeros(size1, size2);
b = zeros(size1, size2);
%c = zeros(1, size);
y = zeros(1, size1);
x = zeros(1, size2);
count1 = 1;
size(b)
for i = start1:step1:stop1
    count2 = 1;
    for j = start2:step2:stop2
        x(count2) = j;
        a(count1, count2) = i;
        b(count1, count2) = calcPercentage7(method, numSim, j, L, i,3);
   
        count2 = count2 + 1;
    end
    y(count1) = i;
    count1 = count1 + 1;
end
%HeatMap(b, 'DisplayRange', 1, 'Symmetric', false);
surf(x, y, b);