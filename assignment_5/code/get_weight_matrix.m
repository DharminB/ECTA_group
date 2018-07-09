function wMat = get_weight_matrix(WeightVector, nF, nH)
nInputs = 1; 
nFeatures = nF;
nHidden = nH; 
nOutputs = 1;
nNode = nFeatures+nHidden+nOutputs;
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


end