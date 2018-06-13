function output = my_cma_es(nacafoil)

% Algorithm Parameters
nGenes  = 32;
lambda = 14;
sigma = 0.01;
change_in_sigma = 0.01;
maxGen = 500;

mu = floor(lambda/2);
weights = zeros([1,mu]);
for i = 1:mu
    weights(i) = mu - i + 1;
end
weights = weights/sum(weights);
mueff = 1/(sum(weights.^2));
C = eye(nGenes);
c_1 = 2/(nGenes^2);
c_mu = min(mueff/(nGenes^2), 1-c_1);
C_mu = 0;
meanInd = rand(1,32)-0.5;

bestFit = zeros([maxGen, 1]);
medianFit = zeros([maxGen, 1]);

successful_mutation = 0;    
% freq_success_mut = 0;
prev_status = 0;
p = 5;      % number of generation at which freq_success_mut is update

% Create an individual (consisting of 32 y values between -0.5 and 0.5)
% pop = (rand(popSize,32)-0.5);

for iGen=1:maxGen
    iGen
    
    % Mutation
    mutated_children = cma_es_mutation(meanInd, sigma, lambda,C);
%     size(mutated_children)
    fitness_mutated_children = mse(mutated_children, nacafoil);
    
    [fitness_sorted, indices] = sort(fitness_mutated_children);
    sorted_children = mutated_children(indices(1:mu),:);
%     size(sorted_children)
    temp = mse(meanInd, nacafoil) > fitness_sorted;
    successful_mutation = successful_mutation + sum(temp);
    
    ind_minus_mean = sorted_children - meanInd;
    meanInd = zeros(1,nGenes);
    for i = 1:mu
        C_mu = C_mu + weights(i) * (ind_minus_mean(i) * ind_minus_mean(i)');
        meanInd = meanInd + (weights(i)*sorted_children(i));
    end
    C_mu = C_mu/mu;
    
    rank_mu_update = c_mu * (1/(sigma^2)) * C_mu;
    y = ind_minus_mean(1)/sigma;
    rank_1_update = c_1 * (y*y');
    
    C = (1 - c_1 - c_mu) * C + rank_1_update + rank_mu_update;
%     C = (1 - c_1) * C + rank_1_update;
%     C = (1 - c_mu) * C + rank_mu_update;

    meanInd(meanInd>0.5) = 0.5; 
    meanInd(meanInd<-0.5) = -0.5; 
    
    
    bestFit(iGen) = min(fitness_sorted);
    medianFit(iGen) = median(fitness_sorted);
    
    
    if mod(iGen, p) == 0
        successful_mutation;
        freq_success_mut = successful_mutation / p
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
        end
        successful_mutation = 0;
        prev_status = curr_status;
        if sigma > 5
            sigma = 5;
        elseif sigma < -5
            sigma = -5;
        end
        sigma
    end
end
% sorted_children(1)
% append to output
output.bestFit = bestFit;
output.medianFit = medianFit;
output.elite = sorted_children(1,:);
    
end