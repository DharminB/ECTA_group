function output = ActivateRNNet(scaledState, WeightVector, nF, nH)
nInputs = 1; 
nFeatures = nF;
nHidden = nH; 
nNode = nFeatures+nHidden;

inputVector = [scaledState(1) scaledState(3) scaledState(5)];

wMat = zeros(nNode);

count = 1;
for i=1:nFeatures
    for j=nFeatures+1:nFeatures+nHidden
        wMat(i,j) = WeightVector(1,count);
        count = count + 1;
    end
end
for i=nFeatures+1:nFeatures+nHidden
    for j=nFeatures+1:nFeatures+nHidden
        if i ~= j
            wMat(i,j) = WeightVector(1,count);
            count = count + 1;
        end
    end
end

nodeAct = zeros(nInputs,nNode);
nodeAct(1:nFeatures) = inputVector;
for i = 1:nNode*nNode
    nodeAct = tanh(nodeAct*wMat);
end
output = nodeAct(nNode);
end
