function output = non_NSGA(pop, popSize, plotgif)
old_pop = unique(pop, 'rows');
fitness = calculateFitness(old_pop);
front = calculateFront(fitness);
elitesIds = elitism(front, popSize);
new_pop = old_pop(elitesIds, :);
fitness = fitness(elitesIds, :);
front = front(elitesIds);

if plotgif == 1
    % plot whole pop
    pause(0.5);
    displayFronts(front, fitness, new_pop);
    gif
    hold on
end

output.new_pop = new_pop;
output.fitness = fitness;
output.front = front;

end