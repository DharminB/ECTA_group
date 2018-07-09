function output = ActivateFFNet(scaledState, WeightVector, nF, nH)
% The weight matrix is the individual.
nInputs = 1; 
nFeatures = nF;
nHidden = nH; 
nOutputs = 1;
nNode = nFeatures+nHidden+nOutputs;

inputVector = scaledState;

% initialise weights with 0
wMat = get_weight_matrix(WeightVector, nFeatures, nHidden);

% Put the input in as the activation of the input nodes
nodeAct = zeros(nInputs,nNode);
nodeAct(1:nFeatures) = inputVector;

for iNode = (nFeatures+1):nNode
   nodeAct(iNode) = tanh(nodeAct*wMat(:,iNode)); 
end

output = nodeAct(nNode);
end
