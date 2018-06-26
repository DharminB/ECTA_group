function output = non_NSGA(pop, popSize)
old_pop = pop(1:popSize, :);
mutated_children = pop(popSize+1:end, :);

fitness = calculateFitness(old_pop);
front = calculateFront(fitness);


elites = elitism(front, old_pop);
% size(elites)
new_pop = vertcat(elites, mutated_children(1:end,:));

output.new_pop = new_pop(1:popSize,:);
output.fitness = fitness(1:popSize, :);
output.front = front(1:popSize);

end