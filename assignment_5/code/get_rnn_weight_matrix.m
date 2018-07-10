function wMat = get_rnn_weight_matrix(WeightVector, nF, nH)
nFeatures = nF;
nHidden = nH; 
nNode = nFeatures+nHidden;
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



end