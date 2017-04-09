function [] = parse_output()
	fclose('all');
    cluster = 125;
	total = 500000; %see $cluster.info file = queue# * numSims
    L = 100;
    start = 0;
    step = .00005;
    stop = .005;
	files = dir(sprintf('outdir/varyRate.%u.*.out',cluster));
	numFiles = size(files);
    numFiles = numFiles(1);
    disp(numFiles);
    [arrayLength, ~] = size(fscanf(fopen(sprintf('outdir/%s',files(1).name)), '%f\n'));
    arrayLength = arrayLength/4;
    disp(arrayLength);
    %rateArray = zeros(1, numFiles)
    
    rateArray = zeros(1, arrayLength);
    minArray = zeros(1, arrayLength);
    avgArray = zeros(1, arrayLength);
    majArray = zeros(1, arrayLength);
    %load the data from the files
    rateArray = start:step:stop;
	for t = 1:(numFiles)
		x = fscanf(fopen(sprintf('outdir/%s',files(t).name)), '%f\n');
        disp(files(t).name);
        disp(x);
        %disp(t);
        %disp(x(1));
        %disp(files(t).name);
        for j = 1:arrayLength
            %disp(j);
            %rateArray(j) = x(4*(j-1)+1);
            %disp(4*(j-1)+2);
            disp('here');
            disp(x);
            disp(x(2));
            minArray(j) = minArray(j) + x(4*(j-1)+2);
            avgArray(j) = avgArray(j) + x(4*(j-1)+3);
            majArray(j) = majArray(j) + x(4*(j-1)+4);
        end
        fclose('all');
    end
    %renormalize to percentages
    for i = 1:arrayLength
        minArray(i) = minArray(i)/total;
        avgArray(i) = avgArray(i)/total;
        majArray(i) = majArray(i)/total;
    end
    %transform to decay rates
    for i = 1:arrayLength
        if minArray(i)==1
            minArray(i) = (-log(1/total)/L);
            disp('here');
        else
            minArray(i) = (-log(1-minArray(i))/L);
        end
        if avgArray(i)==1
            avgArray(i) = (-log(1/total)/L);
        else
            avgArray(i) = (-log(1-avgArray(i))/L);
        end
        if majArray(i)==1
            majArray(i) = (-log(1/total)/L);
        else
            majArray(i) = (-log(1-majArray(i))/L);
        end
    end
        
    plot(rateArray, minArray, 'r', rateArray, avgArray, 'g', rateArray, majArray, 'b');
    fclose('all');
end
		
