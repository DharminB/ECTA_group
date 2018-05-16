function distance = fitness(distMat, pop, popSize, nGenes)
distance = [];
    for i=1:popSize
        ind = pop(i,:);
        idistance = distMat(ind(1), ind(end));
        for iCity = 2:nGenes
            twoCityIndices= [ind(iCity-1), ind(iCity)]; % Indices of distance matrix
            idistance = idistance + distMat(twoCityIndices(1), twoCityIndices(2));
        end
        distance = vertcat(distance, idistance);
    end
end
