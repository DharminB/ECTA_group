function children = crossover(parentIds, pop, crossProb)
children = [];
popSize = size(pop,1);
nGenes = size(pop,2);
    for i = 1:popSize
        parentA = parentIds(i,1);
        parentB = parentIds(i,2);
        
        % generate a float (0 to 1) and do crossover if less than crossProb
        if rand(1) < crossProb
%             splitPoint = randi(nGenes-1);
%             parentAGenes = pop(parentA,1:splitPoint);
%             parentBGenes = pop(parentB,splitPoint+1:end);
%             child = [parentAGenes, parentBGenes];
            parentAGenes = pop(parentA,:);
            parentBGenes = pop(parentB,:);
            child = mean([parentAGenes; parentBGenes], 1);
        else
            child = pop(parentA,:);
        end
        children = vertcat(children, child);
    end
end