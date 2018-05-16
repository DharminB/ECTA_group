function mutated_children = mutation(children, nGenes, mutProb)
    mutated_children = [];
    sizeOfChildren = size(children);
    for ichild = 1:sizeOfChildren(1)
        % generate a random float (0 to 1) for every individual
        random_number = rand(1);
        if random_number < mutProb
            % we do partial shuffle mutation
            % we randomly select 2 indices and reverse that substring
            i = randi(nGenes-1);
            j = randi([i+1, nGenes]);
            child = children(ichild,:);
            mutatedGenes = fliplr(child(i:j));
            mutated_child = [child(1:i-1) mutatedGenes child(j+1:end)];
        else
            mutated_child = children(ichild,:);
        end
        mutated_children = vertcat(mutated_children,mutated_child);
    end
end
