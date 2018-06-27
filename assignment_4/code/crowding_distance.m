function P_dist = crowding_distance(fitness)
    popSize = size(fitness,1);
    nObjectives = size(fitness,2);
    P_dist = zeros(popSize,1);
    for k = 1:nObjectives
        fmax = max(fitness(:,k));
        fmin = min(fitness(:,k));
        [P, indices] = sortrows(fitness(:,k));
        P_dist(indices(1)) = Inf;
        P_dist(indices(popSize)) = Inf;
        for i = 2:popSize-1
            P_dist(indices(i)) = P_dist(indices(i)) + (P(i+1)-P(i-1))/(fmax-fmin);
        end
    end
%     P_dist = P_dist(indices);
end