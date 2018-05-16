function children = crossover(parentIds, pop, nGenes)
children = [];
    for i = 1:popSize
        parentA = parentIds(i,1);
        parentB = parentIds(i,2);

        % Select a point to split genes
        %   Here we do 1 point crossover. Can you think of any advantage of doing
        %   '2 point' crossover?
        splitPoint = randi(nGenes);
        parent1Genes = pop(parentA,[1:splitPoint]);

        % Find the values in [1:nCities] that are NOT in parent1Genes
        missing = setdiff(1:nGenes,parent1Genes);

        % Get those missing values in parent2, in the same order ('stable') 
        parent2Genes = intersect( pop(parentB,:) ,missing,'stable');

        child = [parent1Genes, parent2Genes];
        children = vertcat(children, child);
    end
end