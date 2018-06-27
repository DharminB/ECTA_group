function elitesIds = elitism(front, popSize)
    front_size = size(front);
    if front_size < popSize 
        elitesIds = ones(popSize,1);
        [sf, indices] = sort(front);
        elitesIds(1:front_size) = indices;
    else
        [sf, indices] = sort(front);
        elitesIds = indices(1:popSize);
    end
end