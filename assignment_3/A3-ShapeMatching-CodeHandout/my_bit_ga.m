function output = my_bit_ga(nacafoil, total_eval, verbose)

% Algorithm Parameters
nBit = 12;
popSize = 20;
nGenes  = 32*nBit;
maxGen = total_eval/popSize;
sp = 2; % selection pressure
mutProb = 1/nGenes; % probability for an individual to mutate
crossProb = 0.99; % probability for crossover
bestFit = zeros([maxGen, 1]);
medianFit = zeros([maxGen, 1]);
    
% Create an individual (consisting of 32 y values between -0.5 and 0.5)
pop = randi(2,popSize, nGenes)-1;

for iGen=1:maxGen
    float_pop = bit2float(pop, nBit);
    fitness = mse(float_pop, nacafoil);
    bestFit(iGen) = min(fitness);
    medianFit(iGen) = median(fitness);
    % Selection
    parentIds = selection(fitness, sp);

    % Crossover
    children = bit_crossover(parentIds, pop, crossProb);

    % Mutation
    mutated_children = bit_mutation(children, mutProb);

    % Elitism
    eliteIds = elitism(fitness);
    elite = pop(eliteIds,:);
    pop = vertcat(elite, mutated_children(1:end-1,:));
    if verbose == 1
        disp([iGen min(fitness)])
    end
end

% append to output
output.bestFit = bestFit;
output.medianFit = medianFit;
output.elite = bit2float(elite, nBit);
    
end