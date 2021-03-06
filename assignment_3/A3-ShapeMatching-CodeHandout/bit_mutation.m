function mutated_children = bit_mutation(children, mutProb)
    mutated_children = children;
    popSize = size(children, 1);
    nGenes = size(children, 2);
    for ichild = 1 : popSize
        for j = 1 : nGenes
            % generate a random float(0 to 1) for every gene in a child
            random_number = rand(1);
            if random_number < mutProb
                mutated_children(ichild,j) = (randi(2,1,1)-1);
            end        
        end
    end
end
