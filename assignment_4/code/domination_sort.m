function front = domination_sort(fitness)
    % This implements the algorithm described in slide 16
    popSize = size(fitness, 1);
    front = zeros(popSize, 1);
    n = zeros(popSize, 1);
    S = zeros(popSize, popSize);
    for j = 1:popSize
        for k = 1:popSize
            if domination(fitness(j,:),fitness(k,:))
                % instead of moving around the individual, we just store it
                % in binary matrix called S
                S(j,k) = 1;
            elseif domination(fitness(k,:),fitness(j,:))
                n(j) = n(j) + 1;
            end
        end
        if n(j) == 0
            front(j) = 1;
        end
    end
    i = 1;
    index_list = 1:popSize;
    while sum(front==i)
        Q = zeros(popSize, 1);
        for j = index_list(front==i)
            for k = index_list(S(j,:)==1)
                n(k) = n(k) - 1;
                if n(k) == 0
                    front(k) = i+1;
                end
            end 
        end
        i = i + 1;
    end
end