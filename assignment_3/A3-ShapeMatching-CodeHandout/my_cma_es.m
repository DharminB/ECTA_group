function output = my_cma_es(nacafoil, total_eval, verbose)

% Algorithm Parameters
nGenes  = 32;
lambda = 10;
sigma = 0.1;
change_in_sigma = 0.5;
maxGen = total_eval/lambda;

mu = floor(lambda/2);
% weights = zeros([1,mu])+1/mu;
weights = zeros([1,mu]);
for i = 1:mu
    weights(i) = mu - i + 1;
end
weights = weights/sum(weights);
mueff = 1/(sum(weights.^2));
C = eye(nGenes);
c_1 = 2/(nGenes^2);
c_mu = min(mueff/(nGenes^2), 1-c_1);
C_mu = zeros(nGenes, nGenes);

% randomly generated individual
meanInd = rand(1,32)-0.5;

bestFit = zeros([maxGen, 1]);
medianFit = zeros([maxGen, 1]);

successful_mutation = 0;    
p = 5;      % sigma is updated every p generations


for iGen=1:maxGen
    % Mutation
    mutated_children = cma_es_mutation(meanInd, sigma, lambda,C);
    fitness_mutated_children = mse(mutated_children, nacafoil);
    
    % sort children according to fitness and choose first mu
    [fitness_sorted, indices] = sort(fitness_mutated_children);
    sorted_children = mutated_children(indices(1:mu),:);

    % update successful_mutation
    temp = mse(meanInd, nacafoil) > fitness_mutated_children;
    successful_mutation = successful_mutation + sum(temp);
    
    % update covariance matrix based on new children
    ind_minus_mean = sorted_children - meanInd;
    for i = 1:mu
        C_mu = C_mu + weights(i) * (ind_minus_mean(i,:)' * ind_minus_mean(i,:));
    end
    C_mu = C_mu/mu;
    
    rank_mu_update = c_mu * (1/(mueff^2)) * C_mu;
    y = ind_minus_mean(1,:)/mueff;
    rank_1_update = c_1 * (y'*y);
    C = (1 - c_1 - c_mu) * C + rank_1_update + rank_mu_update;

    % calculate new mean
    meanInd = weights*sorted_children;
    meanInd(meanInd>0.5) = 0.5; 
    meanInd(meanInd<-0.5) = -0.5; 
    
    bestFit(iGen) = min(fitness_sorted);
    medianFit(iGen) = median(fitness_sorted);
    
    % update sigma every p generation with 1/5th rule
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
            disp([iGen fitness_sorted(1) sigma])
        end
    end
    
end
output.bestFit = bestFit;
output.medianFit = medianFit;
output.elite = meanInd;
    
end