function [] = parse_output()
	fclose('all');
    cluster = 319;
	total = 500000; %see $cluster.info file
    L = 100;
	files = dir(sprintf('outdir/basicSimul.%u.*.out',cluster));
	numFiles = size(files);
    
    [arrayLength, ~] = size(fscanf(fopen(sprintf('outdir/%s',files(1).name)), '%f\n'));
    arrayLength = arrayLength/4;
    disp(arrayLength);
    %rateArray = zeros(1, numFiles)
    
    rateArray = zeros(1, arrayLength);
    minArray = zeros(1, arrayLength);
    avgArray = zeros(1, arrayLength);
    majArray = zeros(1, arrayLength);
    %load the data from the files
	for t = 1:(numFiles)
		x = fscanf(fopen(sprintf('outdir/%s',files(t).name)), '%f\n');
        for j = 1:arrayLength
            rateArray(j) = x(4*(j-1)+1);
            minArray(j) = minArray(j) + x(4*(j-1)+2);
            avgArray(j) = avgArray(j) + x(4*(j-1)+3);
            majArray(j) = majArray(j) + x(4*(j-1)+4);
        end
    end
    %renormalize to percentages
    for i = 1:arrayLength
        minArray(i) = minArray(i)/total;
        avgArray(i) = avgArray(i)/total;
        majArray(i) = majArray(i)/total;
    end
    %transform to decay rates
    for i = 1:arrayLength
        minArray(i) = (minArray(i)==0)*(-log(1/total)/L)+(minArray(i)~=0)*(-log(1-minArray(i))/L);
        avgArray(i) = (avgArray(i)==0)*(-log(1/total)/L)+(avgArray(i)~=0)*(-log(1-avgArray(i))/L);
        majArray(i) = (majArray(i)==0)*(-log(1/total)/L)+(majArray(i)~=0)*(-log(1-majArray(i))/L);
    end
        
    plot(rateArray, minArray, 'r', rateArray, avgArray, 'g', rateArray, majArray, 'b');
    fclose('all');
end
		
