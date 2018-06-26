function front = naive_domination_sort(fitness)
    i = 1
    popSize = size(fitness,1)
    front = zeros(popSize,1)
    fitness_back_up = fitness
    while sum(front == 0) > 0
        for j = 1:popSize
            % To prevent already assigned fronts being over written
            if front(j) == 0
                front(j) = i
                for k = 1:popSize
                    if j ~= k && front(k) == 0 || front(k) == i
%                         if (fitness(k,1) > fitness(j,1) && fitness(k,2) >= fitness(j,2)) || (fitness(k,1) >= fitness(j,1) && fitness(k,2) > fitness(j,2))
                          if domination(fitness(k,:),fitness(j,:))
                            front(j) = 0
                            break
                        end
                    end
                end
            end
        end
%         %only unassigned fronts are to be included
%         This would cause issues if we remove elements from the fitness
%         array. So we keep this constant and just add an if condition to
%         prevent overwritting of already assigned fronts.
%         fitness = fitness(front == 0)
        i = i + 1
%         front
    end
%     front
end