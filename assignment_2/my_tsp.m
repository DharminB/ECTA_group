function output = my_tsp(distMat)
    
    sizeOfMat = size(distMat);
    % Algorithm Parameters
    popSize = 100;
    nGenes  = sizeOfMat(1);
    maxGen = 3000;
    crossoverPtNum = 2;
    sp = 2; % selection pressure
    mutProb = 0.1; % probability for an individual to mutate
    crossProb = 0.99; % probability for crossover
    bestArray = [];
    medianArray = [];
    
    % Create a population
    for iPop = 1:popSize
        pop(iPop,:) = randperm(nGenes);
    end

    % looping for generation
    for iGen=1:maxGen
        popFitness = fitness(distMat,pop);
        bestFit = min(popFitness);
        bestArray = [bestArray bestFit];
        medianFit = median(popFitness);
        medianArray = [medianArray medianFit];

        % Selection
        parentIds = selection(popFitness, popSize, sp);

        % Crossover
        children = crossover(parentIds, pop, crossProb, crossoverPtNum);

        % Mutation
        mutated_children = mutation(children, nGenes, mutProb);

        % Elitism
        eliteIds = elitism(popFitness);
        elite = pop(eliteIds,:);
        pop = vertcat(elite, mutated_children(1:end-1,:));
    end
 
    % append to output
    output.bestArray = bestArray;
    output.medianArray = medianArray;
    output.elite = elite;
    

end