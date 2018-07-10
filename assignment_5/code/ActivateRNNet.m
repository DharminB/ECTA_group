function output = ActivateRNNet(nodeAct, wMat, nF, nH)
nInputs = 1; 
nFeatures = nF;
nHidden = nH; 
nNode = nFeatures+nHidden;

nodeAct = tanh(nodeAct*wMat);
output.action = nodeAct(nNode);
output.nodeAct = nodeAct;
end
