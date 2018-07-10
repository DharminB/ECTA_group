function output = esp_algorithm(initialState, scaling, popSize, maxGen, totalSteps, nF, nH)
% Initialization
nHidden = nH;
nFeatures = nF;
nSubPopSize = 15;
nInputs = 1;
% nNode = nFeatures+nHidden;
% RNN genes
nGenes = (nFeatures*nHidden) + (nHidden*(nHidden-1));
popSize = nSubPopSize*nHidden;
% Create population
pop = rand(popSize,nGenes);
fitness = zeros(1,popSize);

% Evaluation
% Randomly Select individual from each subpop
pCount = 1;
selectedNeurons = zeros(nHidden,nFeatures);
for i=1:nHidden
    Id = randi([pCount pCount+nSubPopSize-1]);
    selectedNeurons(i,:) = pop(Id, :);
    pCount = pCount+nSubPopSize;
end

% Form an RNN from these selected neurons

end