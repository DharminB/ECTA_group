function fitness = calculateFitness3(pop)
    popSize = size(pop,1);
    nGenes = size(pop,2);
    fitness = zeros(popSize,3);
    mask1 = repmat([0 1], 1, nGenes/2);
    mask2 = repmat([1 0], 1, nGenes/2);
    somearray = 1:nGenes+2;
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
        
        masked_one_ind = [1 xor(mask1, pop(i,:)) 1];
        masked_two_ind = [1 xor(mask2, pop(i,:)) 1];
        m1 = max(diff(somearray(masked_one_ind==1)));
        m2 = max(diff(somearray(masked_two_ind==1)));
        fitness(i,3) = max(m1, m2) - 1;
    end
end
