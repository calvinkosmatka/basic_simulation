function result = inferenceAverage6(GeneDistanceArray, numGenes, numSims)
    result = zeros(1, numSims);
    for i = 1:numSims
        M = mean(GeneDistanceArray(((i-1)*numGenes+1):i*numGenes,:));
        [~, result(i)] = min(M);
    end
end