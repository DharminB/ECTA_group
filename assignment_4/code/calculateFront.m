function front = calculateFront(fitness)
popSize = size(fitness, 1);
front = zeros(popSize, 1);
total_fitness = sum(fitness,2);
maximum = max(total_fitness);
for i=1:maximum+1
    front(total_fitness == maximum+1-i) = i;
end
% [something, index] = sortrows(fitness);
% somearray = 1:popSize;
% index = flipud(index);
% front = somearray(index);
% front = front';
end