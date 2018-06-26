function new_pop = NSGA2(pop, children, fitness_parent, fitness_children)
    R = vertcat(pop, children)
    N = size(pop)
    fitness = vertcat(fitness_parent, fitness_children)
    front = naive_domination_sort(fitness)
    i = 1
    new_pop = []
    while size(new_pop,1) + size(front(front == i),1) <= N
        new_pop = vertcat(new_pop, R(front == i)
        i = i + 1
    end
    distance = crowding_distance(fitness(front == i))
    sorted_fitness = sortrows(distance)
    new_pop = vertcat(new_pop, sorted_fitness(1:N-size(new_pop))
end-