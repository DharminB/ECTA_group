function es_output = my_es(initialState, scaling, popSize, maxGen, totalSteps, nF, nH, NNId)
% Algorithm Parameters
lambda = 1;
sigma = 1.0;
change_in_sigma = 0.5;

nFeatures = nF;
nHidden = nH;
if NNId == 1
    % Then FFNet
    nOutputs = 1;
    nGenes = (nFeatures*nHidden) + (nHidden*nOutputs);
else
    % Then RNN
    nGenes = ((nFeatures+1)*nHidden) + (nHidden*(nHidden-1));
end
verbose = 1;
bestFit = zeros([maxGen, 1]);

successful_mutation = 0;
p = 5;      % sigma is updated every p generations

pop = rand(popSize,nGenes);
fitness = zeros(1,popSize);
oldPopSize = 1;

for iGen=1:maxGen
    % Selection
    parentIds = es_selection(popSize, lambda);
    % Mutation
    mutated_children = es_mutation(pop, parentIds, sigma);
    popSize = oldPopSize + lambda;
%     pop = [pop; mutated_children];
    pop = vertcat(pop, mutated_children);
    for iPop = 1:popSize
        Weights = pop(iPop,:);
        if NNId == 1
            step = simulation(totalSteps, initialState, scaling, Weights, nFeatures, nHidden, 0);
        else
            step = simulation_rnn(totalSteps, initialState, scaling, Weights, nFeatures+1, nHidden, 0);
        end
        fitness(1, iPop) = step.fitness;
    end
    fitness_mutated_children = fitness(oldPopSize+1:end);
    fitness_parent = fitness(1:oldPopSize);
    for i=1:lambda
        if fitness_parent < fitness_mutated_children(i)
            successful_mutation = successful_mutation+1;
        end
    end

    % sort them
    [sorted_fitness, indices] = sort(fitness);
    indices = fliplr(indices);
    sorted_fitness = fliplr(sorted_fitness);
    popSize = oldPopSize;
    % select only top mu individuals (and their fitnesses)
    pop = pop(indices(1:popSize),:);
    fitness = sorted_fitness(1:popSize);
    bestFit(iGen) = fitness(1);

    % update sigma every p generations with 1/5th rule
    if mod(iGen, p) == 0
        freq_success_mut = successful_mutation / p;
        if freq_success_mut < 0.2
            sigma = sigma * change_in_sigma;
        elseif freq_success_mut > 0.2
            sigma = sigma / change_in_sigma;
        end
        successful_mutation = 0;
        if verbose == 1
            % print progress
            disp([iGen fitness(1) sigma])
        end
    end
end

% append to output
es_output.bestFitness = bestFit;
es_output.elite = pop(1,:);
end