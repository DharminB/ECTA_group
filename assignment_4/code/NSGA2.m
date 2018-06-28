function output = NSGA2(pop, popSize, plotgif)
    R = unique(pop, 'rows');
    N = popSize;
    r_size = size(R, 1);
    fitness = calculateFitness3(R);
    front = domination_sort(fitness);

    if plotgif == 1
        % plot whole pop
        pause(0.1);
        displayFronts(front, fitness, R);
        gif
        hold on
    end
    
    i = 1;
    new_pop = [];
    b = [];
    a = [];
    max_front = max(front);
    while size(new_pop,1) + size(front(front == i),1) <= N && i <= max_front
        new_pop = vertcat(new_pop, R((front == i),:));
        b = vertcat(b, front(front == i));
        a = vertcat(a, fitness((front == i),:));
        i = i + 1;
    end
    if i <= max_front
        distance = crowding_distance(fitness(front == i, :));
        [sorted_distances, indices] = sort(distance);
        indices = flipud(indices);
        somearray = 1:r_size;
        actual_indices = somearray(front==i);
        indices = actual_indices(indices)';
        a = vertcat(a, fitness(indices(1:N-size(new_pop, 1)),:));
        new_pop = vertcat(new_pop, R(indices(1:N-size(new_pop, 1)),:));
        b = vertcat(b, front(front == i));
        b = b(1:popSize);
    end
    if plotgif == 1
        % plot whole pop with next gen markers
%         [C, greenIndices, ib] = intersect(R, new_pop, 'rows');
%         pause(0.05);
%         displayFrontsWithMarkers(front, fitness, R, greenIndices);
%         gif
%         hold on
    end
    
    output.new_pop = new_pop;
    output.fitness = a;
    output.front = b;
end