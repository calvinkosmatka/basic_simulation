function alpha = calcAlpha6(method, simTimes, height, geneNum)
%assume that the desired result is [1 2]
    % only do the simulations if there is a reasonable chance of not
    % getting all successes
    % based on the success probability of ML (min) the following condition
    % should be met. For other methods this bound should be lower
    if simTimes > 3*(exp(height*geneNum))/2
        distanceArray = simul6(1+height, 1, geneNum, simTimes);
        x = method(distanceArray, geneNum, simTimes);
        hist = histcounts(x, [1,2,3,4]);
        failpercentage = 1 - (hist(1) / simTimes);
        alpha = - log(failpercentage) / geneNum;
    else
        % For large heights, even with large numbers of simulations, the
        % failure probability is low enough that the inference works every
        % time (i.e. count == simTimes). In this case, we can calculate an approximate lower
        % bound for alpha. We know the empirical failure probability
        % is less than 1/simTimes if count == 0.
        % This gives the highest possible value of alpha that could be
        % calculated using the given number of simulation times.
        alpha = -log((1/simTimes)) / geneNum;
    %else
    %    failpercentage = 1 - (count / simTimes);
    %    alpha = - log(failpercentage) / geneNum;
    end
end