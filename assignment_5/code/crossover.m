function children  = crossover(pop, parentIds, crossProb)
children = [];
sizeOfParent = size(parentIds);
nGenes = size(pop, 2);
for i = 1:sizeOfParent(1)
    % create random number to decide whether to crossover or not
    random_number = rand(1);
    if random_number < crossProb
        % randomly generate a crossover point where the gene will be spliced
        crossPoint = randi(nGenes);
        parentA = pop(parentIds(i,1),:);
        parentB = pop(parentIds(i,2),:);
        % merge the parents genes at crosspoint
        child = [parentA(1:crossPoint) parentB(1+crossPoint:end)];
%         child = (parentA + parentB)/2;
    else
        % assign first parent's gene to child without change
        child = pop(parentIds(i,1),:);
    end
    % add child's gene to genepool
    children = vertcat(children, child);
end