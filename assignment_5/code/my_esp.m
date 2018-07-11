function output = my_esp(initialState, scaling, popSize, maxGen, totalSteps, nTrials, nF, nH)
% Initialization
nHidden = nH;
nFeatures = nF;
nGenes = nFeatures + nHidden; % genes for RNN
mutProb = 3/nGenes;
% Create population
pop = rand(popSize,nGenes, nHidden);
elite = zeros(nGenes);

bestFitness = zeros(1, maxGen);
for iGen=1:maxGen
    fitness = zeros(popSize, nHidden);
    count = zeros(popSize, nHidden);
    % Evaluation
    while min(min(count)) < nTrials
        wMat = zeros(nGenes);
        neuron_index = randi(popSize, 1, nHidden);
        for iNode=1:nHidden
            index = neuron_index(iNode);
            wMat(:, nFeatures + iNode) = pop(index, :, iNode)';
            wMat(nFeatures + iNode, nFeatures + iNode) = 0;
            count(index, iNode) = count(index, iNode) + 1;
        end
%         wMat
        nn_fitness = simulation_esp(totalSteps, initialState, scaling, wMat, nFeatures, nHidden, 0);
        if bestFitness(iGen) < nn_fitness.fitness
            bestFitness(iGen) = nn_fitness.fitness;
            elite = wMat;
        end
        for iNode=1:nHidden
            index = neuron_index(iNode);
            fitness(index, iNode) = fitness(index, iNode) + nn_fitness.fitness;
        end
    end
    % recombination
    avg_fitness = fitness./count;
    quartile = ceil(popSize/4);
    for iNode=1:nHidden
        [sf, indices] = sort(avg_fitness(:, iNode), 'descend');
        top_quartile_pop = pop(indices(1:quartile), :, iNode);
        children = crossover(top_quartile_pop, randi(quartile, popSize/2, 2), 1.0);
%         children = crossover(top_quartile_pop, horzcat(randi(quartile, popSize/2, 1), ones(popSize/2, 1)), 1.0);
        mutated_children = mutation(children, mutProb);
%         pop(1:quartile, :, iNode) = top_quartile_pop;
        pop(indices(popSize/2 + 1:end), :, iNode) = mutated_children;

    end
    disp([iGen bestFitness(iGen)])
end
output.bestFitness = bestFitness;
output.elite = elite;
end