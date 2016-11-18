function percentage = calcPercentage7(method, simTimes, height, geneNum,recomRate,div2)
%assume that the desired result is [1 2]
    % only do the simulations if there is a reasonable chance of not
    % getting all successes
    % based on the success probability of ML (min) the following condition
    % should be met. For other methods this bound should be lower
    
        distanceArray = simulWithRc5(div2+height, div2, geneNum, recomRate,simTimes);
        x = method(distanceArray, geneNum, simTimes);
        hist = histcounts(x, [1,2,3,4]);
        % fail percentage
        percentage = 1 - (hist(1) / simTimes);
       
        % For large heights, even with large numbers of simulations, the
        % failure probability is low enough that the inference works every
        % time (i.e. count == simTimes). In this case, we can calculate an approximate lower
        % bound for alpha. We know the empirical failure probability
        % is less than 1/simTimes if count == 0.
       
    %else
    %    failpercentage = 1 - (count / simTimes);
    %    alpha = - log(failpercentage) / geneNum;
   
end