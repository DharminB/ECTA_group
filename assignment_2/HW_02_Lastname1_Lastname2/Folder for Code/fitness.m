function distance = fitness(distMat, pop)
distance = [];
sizeOfPop = size(pop);
popSize = sizeOfPop(1);
nGenes = sizeOfPop(2);
    % iterate over individual
    for i=1:popSize
        ind = pop(i,:);
        idistance = distMat(ind(1), ind(end));
        % iterate over cities
        for iCity = 2:nGenes
            twoCityIndices= [ind(iCity-1), ind(iCity)]; % Indices of distance matrix
            idistance = idistance + distMat(twoCityIndices(1), twoCityIndices(2)); % add distance from lookup
        end
        distance = vertcat(distance, idistance);
    end
end
