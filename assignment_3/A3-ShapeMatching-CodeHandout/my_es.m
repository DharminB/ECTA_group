function output = my_es(nacafoil)

% Algorithm Parameters
popSize = 4;
nGenes  = 32;
lambda = popSize/2;
sigma = 0.1;
change_in_sigma = 0.01;
maxGen = 5000;
bestFit = zeros([maxGen, 1]);
medianFit = zeros([maxGen, 1]);

sucessful_mutation = 0;    
freq_success_mut = 0;
prev_status = 0;
p = 5;      % number of generation at which freq_success_mut is update

% Create an individual (consisting of 32 y values between -0.5 and 0.5)
pop = (rand(popSize,32)-0.5);

for iGen=1:maxGen
    iGen
    fitness = mse(pop, nacafoil);
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
    pop = vertcat(pop, mutated_children);
    fitness = vertcat(fitness, fitness_mutated_children);
    [ignore, indices] = sort(fitness);
    pop = pop(indices(1:popSize),:);
    
    if mod(iGen, p) == 0
        sucessful_mutation;
        freq_success_mut = sucessful_mutation / p
        if freq_success_mut - 0.2 <= 0
            curr_status = 1;
        else
            curr_status = 0;
        end
        if (prev_status == curr_status)
            alpha = 1.1;
        else
            alpha = 0.9;
        end
        change_in_sigma = change_in_sigma + (alpha-1)/100;
%         change_in_sigma = change_in_sigma*alpha;
        if freq_success_mut < 0.2
            sigma = sigma + change_in_sigma;
        elseif freq_success_mut > 0.2
            sigma = sigma - change_in_sigma;
        sucessful_mutation = 0;
        end
        prev_status = curr_status;
        
        sigma
end
fitness = mse(pop, nacafoil);
[ignore, indices] = sort(fitness);

% append to output
output.bestFit = bestFit;
output.medianFit = medianFit;
output.elite = pop(indices(1),:);
    
end