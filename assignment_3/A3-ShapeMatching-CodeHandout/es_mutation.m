function mutated_children = es_mutation(pop, parentIds, sigma)
    nGenes = size(pop, 2);
    lambda = size(parentIds,1);
    mutated_children = zeros([lambda, nGenes]);
    mu = zeros(1, nGenes);
    cov = eye(nGenes);
%     sizeMut = size(mutated_children)
    for ichild = 1 : lambda
        parentGenes = pop(parentIds(ichild),:);
        child = parentGenes + sigma * mvnrnd(mu, cov);
        mutated_children(ichild, :) = child;
%         size(mutated_children)
    end
end


