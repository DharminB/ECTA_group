function output = ActivateFFNet(scaledState, WeightVector, nF, nH)
% The weight matrix is the individual.
% Network Configuration :
% 6 input nodes since number of inputs is 6.
% 1 output node since output is just one value.
% 1 hidden layer with 5 nodes.
nInputs = 1; 
nFeatures = nF;
nHidden = nH; 
nOutputs = 1;
nNode = nFeatures+nHidden+nOutputs;

% Input Vector
% inputVector = rand(nInputs, nFeatures);
inputVector = scaledState;
% disp('Input Vector Size: '); disp(size(inputVector));

% Weight Matrix 
% [nInputs X nOutputs]
% wMat = rand(nNode);
% disp('Weight Matrix Size: '); disp(size(wMat))
% 
% wActive = zeros(nNode);
% wActive([1 2 3 4 5 6], [7 8 9 10 11]) = 1; % In to Hidden connections
% wActive([7 8 9 10 11]  , 12) = 1; % Hidden to Out connections
% 
% % Turn inactive connections to 0;
% wMat = wMat.*wActive;
wMat = zeros(nNode);
count = 1;
for i=1:nFeatures
    for j=nFeatures+1:nFeatures+nHidden
        wMat(i,j) = WeightVector(1,count);
        count = count + 1;
    end
end
for j=nFeatures+1:nFeatures+nHidden
    wMat(j,nNode) = WeightVector(1,count);
    count = count + 1;
end

% Put the input in as the activation of the input nodes
nodeAct = zeros(nInputs,nNode);
nodeAct(1:nFeatures) = inputVector;

for iNode = (nFeatures+1):nNode
   nodeAct(iNode) = tanh(nodeAct*wMat(:,iNode)); 
end

output = nodeAct(nNode);
end
