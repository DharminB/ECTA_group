function fitness = calculateFitnessbinary(pop)
    popSize = size(pop,1);
    nGenes = size(pop,2);
    fitness = zeros(popSize,2);
    for i = 1 : popSize
%         ind = pop(i,:);
        b = find(~pop(i,:), 1, 'last');
        if isempty(b)
            b = 0;
        end
        fitness(i,1) = bin2dec(num2str(pop(i,:)));
        fitness(i,2) = nGenes - b;
    end
end