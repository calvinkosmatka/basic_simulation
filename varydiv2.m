function [] = varydiv2(process, geneNum, simTimes, rate, t, start, stop, step)
	process = str2num(process);
	geneNum = str2num(geneNum);
	simTimes = str2num(simTimes);
	rate = str2num(rate);
	t = str2num(t);	
	
	start = str2num(start);
	stop = str2num(stop);
	step = str2num(step);
	size = floor((stop - start)/step)+1;
	
	for div2 = start:step:stop
		disp(div2);
		%			div1	   div2	 	  	 	'input'	u
		distArray = simulWithRc7(div2 + t, div2, geneNum, rate, simTimes,0,	1);
		minResults = inferenceMin6(distArray, geneNum, simTimes);
		avgResults = inferenceAverage6(distArray, geneNum, simTimes);
		majResults = inferenceMajority6(distArray, geneNum, simTimes);
		
		minHist = histcounts(minResults, [1,2,3,4]);
		avgHist = histcounts(avgResults, [1,2,3,4]);
		majHist = histcounts(majResults, [1,2,3,4]);
		
		%return the number correct
		disp(minHist(1));
		disp(avgHist(1));
		disp(majHist(1));
	end

end
