function children = crossover(parentIds, pop, crossProb, crossoverPtNum)
children = [];
sizeOfPop = size(pop);
popSize = sizeOfPop(1);
nGenes = sizeOfPop(2);
    for i = 1:popSize
        parentA = parentIds(i,1);
        parentB = parentIds(i,2);
        
        % generate a float (0 to 1) and do crossover if less than crossProb
        if rand(1) < crossProb 
            
            if crossoverPtNum == 3
                splitPoint1 = randi(nGenes-2);
                splitPoint2 = randi([splitPoint1+2, nGenes]);
                parentAGenes1 = pop(parentA,[1:splitPoint1]);
                parentAGenes2 = pop(parentA,[splitPoint2:end]);

            else
                splitPoint = randi(nGenes-2);
                parentAGenes = pop(parentA,[1:splitPoint]);

                % Find the values in [1:nCities] that are NOT in parent1Genes
                missing = setdiff(1:nGenes,parentAGenes);

                % Get those missing values in parent2, in the same order ('stable') 
                parentBGenes = intersect( pop(parentB,:) ,missing,'stable');

                child = [parentAGenes, parentBGenes];
            end
        else
            child = pop(parentA,:);
        end
        children = vertcat(children, child);
    end
end