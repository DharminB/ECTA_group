function parentIds = selection(fitness, popSize, sp)
parentIds = [];
% iterate over all the individuals in the population
    for i = 1:popSize
        % Randomly select sp individual
        possibleFather = randi(popSize, [1 sp]);
        [val, index] = max(fitness(possibleFather));
        % Select the one with best fitness as the father
        father = possibleFather(index);
        % Randomly select sp individual again
        possibleMother = randi(popSize, [1 sp]);
        [val, index] = max(fitness(possibleMother));
        % Select the one with best fitness as the mother
        mother = possibleMother(index);
        % Pack them together
        pair = [father mother];
%         fitness;
        % Append them to the parentIds list
        parentIds = vertcat(parentIds, pair);
    end
end
