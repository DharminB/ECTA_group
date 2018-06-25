function elites = elitism(front, pop)
    % return the best individual logical array
    eliteIds = front==1;
    elites = pop(eliteIds,:);
    elites = unique(elites, 'rows');
    size(elites);
end