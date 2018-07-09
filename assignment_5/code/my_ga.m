function ga_output = my_ga(initialState, scaling, popSize, maxGen, totalSteps, nF, nH)
nInputs = 1; 
nFeatures = nF;
nHidden = nH; 
nOutputs = 1;
nNode = nFeatures+nHidden+nOutputs;
nGenes = (nFeatures*nHidden) + (nHidden*nOutputs);
% popSize = 100;
sp = 2;
crossProb = 1.0;
mutProb = 1/nGenes;
totalEpisodes = maxGen;

pop = rand(popSize,nGenes);
fitness = zeros(1,popSize);
BestFitness = zeros(1, totalEpisodes);

%Run for 200 episodes
for episode=1:totalEpisodes
    % Run this for each individual to get its fitness
    for iPop = 1:popSize
        Weights = pop(iPop,:);
        step = simulation(totalSteps, initialState, scaling, Weights, nFeatures, nHidden, 0);
        fitness(1, iPop) = step.fitness;
    end
    parentIds = selection(fitness, popSize, sp);
    children = crossover(pop, parentIds, crossProb, nGenes);
    mut_children = mutation(children, nGenes, mutProb);
    eliteIds  = elitism(fitness);
    newPop    = [pop(eliteIds,:); mut_children];
    pop       = newPop(1:popSize,:);
    disp(episode);
    BestFitness(1,episode) = fitness(eliteIds);
end
ga_output.bestFitness = BestFitness;
ga_output.elite = pop(1, :);
end