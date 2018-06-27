function output = my_ga(nGenes, maxGen, popSize, nsga, plotgif)
    
    % Algorithm Parameters
    sp = 2; % selection pressure
    mutProb = 2/nGenes; % probability for mutation
    crossProb = 0.9; % probability for crossover
    
    % generate the population randomly
    pop = randi(2, popSize, nGenes) - 1;
    front = ones(popSize, 1);
    for iGen=1:maxGen
        % Selection
        parentIds = selection(front, sp);

        % Crossover
        children = crossover(parentIds, pop, crossProb);

        % Mutation
        mutated_children = mutation(children, mutProb);
        
        new_pop = vertcat(pop, mutated_children);
        
        if nsga == 1
            output = NSGA2(new_pop, popSize, plotgif);
        else
            output = non_NSGA(new_pop, popSize, plotgif);
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