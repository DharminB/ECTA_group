function mutated_children = cma_es_mutation(meanInd, sigma, lambda, C)
    nGenes = size(meanInd, 2);
%     mutated_children = meanInd + sigma * mvnrnd(zeros(1,nGenes), C, lambda);
    mu = zeros(1, nGenes);
    R = chol(C);
    z = repmat(mu, lambda,1) + randn(lambda,nGenes)*R;
    mutated_children = meanInd + sigma * z;
end


