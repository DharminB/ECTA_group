function penalty = calculateFitness(edgeList, pop)
    popSize = size(pop,1);
    penalty = zeros([popSize,1]);
    for i = 1 : popSize
        ind = pop(i,:);
        % compare the color of end nodes of each edge
        iPenalty = sum(ind(edgeList(:,1)) == ind(edgeList(:,2)));
        penalty(i) = iPenalty;
    end

end
