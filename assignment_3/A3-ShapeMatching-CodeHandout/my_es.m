function output = my_es(nacafoil)

% Algorithm Parameters
popSize = 1;    % mu in ES terms
nGenes  = 32;
lambda = 1;
sigma = 0.1;
change_in_sigma = 0.5;
maxGen = 1000;
bestFit = zeros([maxGen, 1]);
medianFit = zeros([maxGen, 1]);

sucessful_mutation = 0;    
p = 5;      % number of generation at which freq_success_mut is update

% Create an individual (consisting of 32 y values between -0.5 and 0.5)
pop = (rand(popSize,32)-0.5);
fitness = mse(pop, nacafoil);

for iGen=1:maxGen
    bestFit(iGen) = min(fitness);
    medianFit(iGen) = median(fitness);
    % Selection
    parentIds = es_selection(popSize, lambda);

    % Mutation
    mutated_children = es_mutation(pop, parentIds, sigma);

    fitness_mutated_children = mse(mutated_children, nacafoil);
    for i=1:lambda
        if fitness(parentIds(i)) > fitness_mutated_children(i)
            sucessful_mutation = sucessful_mutation+1;
        end
    end
    
    % combine individuals(parent and children) and their fitness
    pop = vertcat(pop, mutated_children);
    fitness = vertcat(fitness, fitness_mutated_children);
    % sort them
    [sorted_fitness, indices] = sort(fitness);
    % select only top mu individuals (and their fitnesses)
    pop = pop(indices(1:popSize),:);
    fitness = sorted_fitness(1:popSize);
    
    % update sigma every p generations with 1/5th rule
    if mod(iGen, p) == 0
        freq_success_mut = sucessful_mutation / p;
        if freq_success_mut < 0.2
            sigma = sigma * change_in_sigma;
        elseif freq_success_mut > 0.2
            sigma = sigma / change_in_sigma;
        end
        sucessful_mutation = 0;
        % print progress
        disp([iGen fitness(1) sigma])
    end
end    

% append to output
output.bestFit = bestFit;
output.medianFit = medianFit;
output.elite = pop(1,:);
    
end