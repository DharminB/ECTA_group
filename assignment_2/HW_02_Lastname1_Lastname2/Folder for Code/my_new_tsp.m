function output = my_new_tsp(distMat, pop, crossProb, mutProb)
    
    sizeOfMat = size(distMat);
    % Algorithm Parameters
    popSize = 100;
    nGenes  = sizeOfMat(1);
    maxGen = 1000;
    crossoverPtNum = 2;
    sp = 2; % selection pressure
    bestArray = [];
    medianArray = [];
    
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