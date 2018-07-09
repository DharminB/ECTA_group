function ga_output = my_ga(initialState, scaling, popSize, maxGen, totalSteps, nF, nH)
nInputs = 1; 
nFeatures = nF;
nHidden = nH; 
nOutputs = 1;
nNode = nFeatures+nHidden+nOutputs;
nGenes = (nFeatures*nHidden) + (nHidden*nOutputs);
% popSize = 100;
sp = 2;
crossProb = 0.6;
mutProb = 0.4;
% totalSteps = 100;
% initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
% scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
state = initialState;
p.simParams.force = 10;
totalEpisodes = maxGen;

% Train the network
% Create a population
% for iPop = 1:popSize
%     pop(iPop,:) = randn(1,nGenes)*0.1;
% end
pop = randn(popSize,nGenes)*0.1;
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