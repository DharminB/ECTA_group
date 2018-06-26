function fitness = calculateFitness(pop)
    popSize = size(pop,1);
    nGenes = size(pop,2);
    fitness = zeros(popSize,2);
    for i = 1 : popSize
%         ind = pop(i,:);
        a = find(pop(i,:), 1, 'first');
        b = find(~pop(i,:), 1, 'last');
        if isempty(a)
            a = nGenes+1;
        end
        if isempty(b)
            b = 0;
        end
        fitness(i,1) = a-1;
        fitness(i,2) = nGenes - b;
    end
end
