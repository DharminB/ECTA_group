function P_dist = crowding_distance(fitness)
    popSize = size(fitness,1);
    nObjectives = size(fitness,2);
    P_dist = zeros(popSize,1);
    for k = 1:nObjectives
        fmax = max(fitness(:,k));
        fmin = min(fitness(:,k));
        [P, indices] = sortrows(fitness(:,k));
        P_dist(1) = Inf;
        P_dist(popSize) = Inf;
        for i = 2:popSize-1
            P_dist(i) = P_dist(i) + (P(i+1)-P(i-1))/(fmax-fmin);
        end
    end
    P_dist = P_dist(indices);
end