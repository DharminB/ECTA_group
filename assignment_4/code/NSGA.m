function output = NSGA(nGenes, maxGen, popSize)
    
    % Algorithm Parameters
    sp = 2; % selection pressure
    mutProb = 1/nGenes; % probability for mutation
    crossProb = 0.8; % probability for crossover
    bestFit = zeros([maxGen, 1]);
    medianFit = zeros([maxGen, 1]);
    
    % generate the population randomly
    pop = randi(2, popSize, nGenes) - 1
    gif('myfile.gif');
%     hold on;
    for iGen=1:maxGen
        pause(0.2);
        fitness = calculateFitness(pop);
%         bestFit(iGen) = min(fitness);
%         medianFit(iGen) = median(fitness);

        % sorting
        front = calculateFront(fitness);
        
        % plotting gif
        displayFronts(front, fitness, pop);
        gif
        hold on
        % Selection
        parentIds = selection(front, sp);

        % Crossover
        children = crossover(parentIds, pop, crossProb);

        % Mutation
        mutated_children = mutation(children, mutProb);

        % Elitism
        elites = elitism(front, pop);
        size(elites)
        pop = vertcat(elites, mutated_children(1:end,:));
        pop = pop(1:popSize,:);
%         pop = mutated_children;
    end
%     hold off;
    % append to output
    output.bestFit = bestFit;
    output.medianFit = medianFit;
    output.elite = pop(1,:);
    

end