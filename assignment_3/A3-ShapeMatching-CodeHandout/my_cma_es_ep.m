function output = my_cma_es_ep(nacafoil)

max_sigma = 0;
min_sigma = 100;

N = 32;
% number of objective variables/problem dimension
xmean = rand(N,1);
% objective variables initial point
sigma = 0.5;
% coordinate wise standard deviation (step-size)
stopfitness = 10; % stop if fitness > stopfitness (minimization)
% Strategy parameter setting: Selection
lambda = 4+floor(3*log(N)); % population size, offspring number
maxGen = 50;
stopeval = maxGen*lambda;
bestFit = zeros([maxGen, 1]);
medianFit = zeros([maxGen, 1]);
% stop after stopeval number of function evaluations

mu = lambda/2;
% lambda=12; mu=3; weights = ones(mu,1); would be (3_I,12)-ES
weights = log(mu+1/2)-log(1:mu)';
% muXone recombination weights
mu = floor(mu);
% number of parents/points for recombination
weights = weights/sum(weights);
% normalize recombination weights array
mueff=sum(weights)^2/sum(weights.^2); % variance-effective size of mu
% Strategy parameter setting: Adaptation
cc = (4+mueff/N) / (N+4 + 2*mueff/N); % time constant for cumulation for C
cs = (mueff+2)/(N+mueff+5); % t-const for cumulation for sigma control
c1 = 2 / ((N+1.3)^2+mueff); % learning rate for rank-one update of C
cmu = 2 * (mueff-2+1/mueff) / ((N+2)^2+2*mueff/2); % and for rank-mu update
damps = 1 + 2*max(0, sqrt((mueff-1)/(N+1))-1) + cs; % damping for sigma
% Initialize dynamic (internal) strategy parameters and constants
pc = zeros(N,1); ps = zeros(N,1);
% evolution paths for C and sigma
B = eye(N);
% B defines the coordinate system
D = eye(N);
% diagonal matrix D defines the scaling
C = B*D*(B*D)';
% covariance matrix
eigeneval = 0;
% B and D updated at counteval == 0
chiN=N^0.5*(1-1/(4*N)+1/(21*N^2)); % expectation of
%||N(0,I)|| == norm(randn(N,1))
% -------------------- Generation Loop --------------------------------
counteval = 0; % the next 40 lines contain the 20 lines of interesting code
iGen = 1;
while counteval < stopeval
    % Generate and evaluate lambda offspring
    for k=1:lambda
        arz(:,k) = randn(N,1); % standard normally distributed vector
        arx(:,k) = xmean + sigma * (B*D * arz(:,k));
        % add mutation
        % Eq. 40
        arfitness(k) = mse(arx(:,k)', nacafoil); % objective function call
        counteval = counteval+1;
    end
    % Sort by fitness and compute weighted mean into xmean
    [arfitness, arindex] = sort(arfitness); % minimization
    xmean = arx(:,arindex(1:mu))*weights;
    % recombination
    % Eq. 42
    zmean = arz(:,arindex(1:mu))*weights;
    % == Dˆ-1*B’*(xmean-xold)/sigma
    % Cumulation: Update evolution paths
    ps = (1-cs)*ps + (sqrt(cs*(2-cs)*mueff)) * (B * zmean);
    % Eq. 43
    hsig = norm(ps)/sqrt(1-(1-cs)^(2*counteval/lambda))/chiN < 1.4+2/(N+1);
    pc = (1-cc)*pc + hsig * sqrt(cc*(2-cc)*mueff) * (B*D*zmean);
    % Eq. 45
    % Adapt covariance matrix C
    C = (1-c1-cmu) * C + c1 * (pc*pc' + (1-hsig) * cc*(2-cc) * C) + cmu * (B*D*arz(:,arindex(1:mu))) * diag(weights) * (B*D*arz(:,arindex(1:mu)))';
    % Adapt step-size sigma
    sigma = sigma * exp((cs/damps)*(norm(ps)/chiN - 1))
    if max_sigma < sigma
        max_sigma = sigma;
    end
    if min_sigma > sigma
        min_sigma = sigma;
    end
    % Eq. 44
    % Update B and D from C
    if counteval - eigeneval > lambda/(c1+cmu)/N/10 % to achieve O(Nˆ2)
        eigeneval = counteval;
        C=triu(C)+triu(C,1)'; % enforce symmetry
        [B,D] = eig(C);
        % eigen decomposition, B==normalized eigenvectors
        D = diag(sqrt(diag(D))); % D contains standard deviations now
    end
    % Break, if fitness is good enough
    % if arfitness(1) >= stopfitness
    %     break;
    % end
    % Escape flat fitness, or better terminate?
    if arfitness(1) == arfitness(ceil(0.7*lambda))
        sigma = sigma * exp(0.2+cs/damps);
        disp('warning: flat fitness, consider reformulating the objective');
    end
    disp([num2str(counteval) ': ' num2str(arfitness(1))]);
    bestFit(iGen) = arfitness(1);
    medianFit(iGen) = median(arfitness);
    medianFit(iGen)
    counteval
    iGen = iGen + 1;
end % while, end generation loop

disp([num2str(counteval) ': ' num2str(arfitness(1))]);
xmin = arx(:, arindex(1));

max_sigma
min_sigma
% sorted_children(1)
% append to output
output.bestFit = bestFit;
output.medianFit = medianFit;
output.elite = arx(:,1)';
    
end