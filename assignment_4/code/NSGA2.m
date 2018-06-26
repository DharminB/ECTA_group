function output = NSGA2(pop, popSize)
    R = pop;
    N = popSize;
    fitness = calculateFitness(R);
%     front = domination_sort(fitness);
    front = naive_domination_sort(fitness);
    i = 1;
    new_pop = [];
    b = [];
    a = [];
    while size(new_pop,1) + size(front(front == i),1) <= N
        new_pop = vertcat(new_pop, R((front == i),:));
        b = vertcat(b, front(front == i));
        a = vertcat(a, fitness((front == i),:));
        i = i + 1;
    end
    distance = crowding_distance(fitness(front == i));
    [sorted_distances, indices] = sort(distance);
    a = vertcat(a, fitness(indices(1:N-size(new_pop)),:));
    new_pop = vertcat(new_pop, R(indices(1:N-size(new_pop)),:));
    b = vertcat(b, front(front == i));
    b = b(1:popSize);
    output.new_pop = new_pop;
    output.fitness = a;
    output.front = b;
end