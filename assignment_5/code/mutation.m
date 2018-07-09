function mutated_children = mutation(children, nGenes, mutProb)
mutated_children = children; 
sizeOfChildren = size(mutated_children);
for i=1:sizeOfChildren(1)
    for j=1:nGenes
        random_number = rand(1);
        if random_number < mutProb
            mutated_children(i,j) = mutated_children(i,j) + randn()*0.1;
        end        
    end
end
