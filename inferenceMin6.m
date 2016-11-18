function results = inferenceMin6(GeneDistanceArray, numGenes, numSims)
    % returns numSims length array of which pair of species is closest
    [mins, inds] = min(GeneDistanceArray, [], 2);
    results = zeros(1,numSims);
    for i = 1:numSims
        [~, k] = min(mins(((i-1)*numGenes+1):i*numGenes,:));
        results(i) = inds(((i-1)*numGenes)+k);
    end
end