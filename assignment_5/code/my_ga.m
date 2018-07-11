function ga_output = my_ga(initialState, scaling, popSize, maxGen, totalSteps, nF, nH, NNId)
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
% popSize = 100;
sp = 2;
crossProb = 0.9;
mutProb = 0.5;
totalEpisodes = maxGen;

pop = rand(popSize,nGenes);
fitness = zeros(1,popSize);
BestFitness = zeros(1, totalEpisodes);

for episode=1:totalEpisodes
    % Run this for each individual to get its fitness
    for iPop = 1:popSize
        Weights = pop(iPop,:);
        if NNId == 1
            step = simulation(totalSteps, initialState, scaling, Weights, nFeatures, nHidden, 0);
        else
            step = simulation_rnn(totalSteps, initialState, scaling, Weights, nFeatures+1, nHidden, 0);
        end
        fitness(1, iPop) = step.fitness;
    end
    parentIds = selection(fitness, popSize, sp);
    children = crossover(pop, parentIds, crossProb);
    mut_children = mutation(children, mutProb);
    eliteIds  = elitism(fitness);
    newPop    = [pop(eliteIds,:); mut_children];
    pop       = newPop(1:popSize,:);
    disp([episode fitness(eliteIds)]);
    BestFitness(1,episode) = fitness(eliteIds);
end
ga_output.bestFitness = BestFitness;
ga_output.elite = pop(1, :);
end