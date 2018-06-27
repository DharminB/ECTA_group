function output = NSGA(nGenes, maxGen, popSize, nsga)
    
    % Algorithm Parameters
    sp = 2; % selection pressure
    mutProb = 2/nGenes; % probability for mutation
    crossProb = 0.9; % probability for crossover
    bestFit = zeros([maxGen, 1]);
    medianFit = zeros([maxGen, 1]);
    
    % generate the population randomly
    pop = randi(2, popSize, nGenes) - 1;
    front = ones(popSize, 1);
    gif('myfile.gif');
    for iGen=1:maxGen
        pause(0.5);
        % Selection
        parentIds = selection(front, sp);

        % Crossover
        children = crossover(parentIds, pop, crossProb);

        % Mutation
        mutated_children = mutation(children, mutProb);
        
        new_pop = vertcat(pop, mutated_children);
        
        if nsga == 1
            output = NSGA2(new_pop, popSize);
        else
            output = non_NSGA(new_pop, popSize);
        end
        pop = output.new_pop;
        front = output.front;
        fitness = output.fitness;
        % plotting gif
%         displayFronts(front, fitness, pop);
%         gif
%         hold on
    end
%     hold off;
    % append to output
    output.pop = pop;
    output.front = front;
    output.fitness = fitness;
    

end