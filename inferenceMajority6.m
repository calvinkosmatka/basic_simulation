function result = inferenceMajority6(GeneDistanceArray, numGenes, numSims)
    [~, ind] = min(GeneDistanceArray, [], 2);
    % one step backward - I suspect there's a subtle trick with indexing
    % here that could be used
    result = zeros(1, numSims);
    for i = 1:numSims
        histogram = histcounts(ind(((i-1)*numGenes+1):i*numGenes,:), [1,2,3,4]);
        [~, m] = max(histogram);
        result(i) = m;
    end
end