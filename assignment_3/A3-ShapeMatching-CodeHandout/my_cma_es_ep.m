function output = my_cma_es_ep(nacafoil)

% Algorithm Parameters
nGenes  = 32;
lambda = 10;
sigma = 0.03;
maxGen = 500;

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
p_C = zeros(1, nGenes);
c_C = 1/nGenes;
p_sigma = zeros(1, nGenes);
c_sigma = 1/nGenes;

meanInd = rand(1,32)-0.5;

bestFit = zeros([maxGen, 1]);
medianFit = zeros([maxGen, 1]);


p = 5;      % number of generation at which freq_success_mut is update


for iGen=1:maxGen
%     iGen
    
    % Mutation
    mutated_children = cma_es_mutation(meanInd, sigma, lambda,C);
    fitness_mutated_children = mse(mutated_children, nacafoil);
    
    [fitness_sorted, indices] = sort(fitness_mutated_children);
    sorted_children = mutated_children(indices(1:mu),:);

    ind_minus_mean = sorted_children - meanInd;
    for i = 1:mu
        C_mu = C_mu + weights(i) * (ind_minus_mean(i,:)' * ind_minus_mean(i,:));
    end
    C_mu = C_mu/mu;
    rank_mu_update = c_mu * (1/(mueff^2)) * C_mu;
    
    new_mean = weights*sorted_children;
    p_C = (1 - c_C)*p_C +  sqrt(c_C * (2 - c_C) * mueff) * (new_mean - meanInd)/sigma;
    
    rank_1_update = c_1 * (p_C' * p_C);

    if mod(iGen, p) == 0
        p_sigma = (1-c_sigma)*p_sigma + (sqrt(c_sigma*(2-c_sigma)*mueff)) * (new_mean - meanInd)/sigma * sqrtm(C);
        sigma = sigma * exp(c_sigma * (norm(p_sigma)/norm(randn(32,1)) - 1));
    end
    
    C = (1 - c_1 - c_mu) * C + rank_1_update + rank_mu_update;
    
    
    meanInd = new_mean;
    meanInd(meanInd>0.5) = 0.5; 
    meanInd(meanInd<-0.5) = -0.5; 
    
    
    bestFit(iGen) = min(fitness_sorted);
    medianFit(iGen) = median(fitness_sorted);
    
    disp([iGen min(fitness_sorted) sigma])
    
%     plotFoil(nacafoil, meanInd);
end
output.bestFit = bestFit;
output.medianFit = medianFit;
output.elite = meanInd;
    
end
