function parentIds = my_selection(fitness, p)
%Selection - Returns indices of parents for crossover
% - Tournament selection:
%   1) N individuals are chosen randomly (N is selection pressure)
%   2) The individual in this subset with the highest fitness is chosen as
%   a parent
%   3) Another N individuals are chosen randomly
%   4) The individual in this subset with the highest fitness is chosen as
%   the other parent
%   5) Repeat steps 1-4 until you have one _pair_ of parents for each child
%   you plan on producing.
%
% Syntax:  parentIds = selection(fitness, p)
%
% Inputs:
%    fitness    - [M X 1] - Fitness of every individual in the population
%    p          - _struct - Hyperparameter struct
%     .sp                   - Selection Pressure
%
% Outputs:
%    parentIds  - [M X 2] - Indices of each pair of parents
%
% See also: crossover, mutation, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%------------- BEGIN CODE --------------

%% This is 'random' selection of parent pairs, can you do better?
% parentIds = randi(p.popSize, [p.popSize 2]);
% father = datasample(p.popSize
parentIds = [];
for i = 1:p.popSize
    possibleFather = randi(p.popSize, [1 p.sp]);
    [val, index] = max(fitness(possibleFather));
    father = possibleFather(index);
    possibleMother = randi(p.popSize, [1 p.sp]);
    [val, index] = max(fitness(possibleMother));
    mother = possibleMother(index);
    pair = [father mother];
    parentIds = vertcat(parentIds, pair);
end
% parentIds
% while(count_1 <= fitness_len)
%     indices_1 = randperm(fitness_len);
%     indices_1 = indices_1(1:p.sp);
%     [val,index_1] = max(fitness(indices_1));
%     if ~(ismember(indices_1(index_1),parent_1))
%        parent_1(count_1) = indices_1(index_1);
%        count_1 = count_1 + 1;
%     end
% end
% parent_2 = double.empty();
% count_2 = 1;
% while(count_2 <= fitness_len)
%     indices_2 = randperm(fitness_len);
%     indices_2 = indices_2(1:p.sp);
%     [val,index_2] = max(fitness(indices_2));
%     if ~(ismember(indices_2(index_2),parent_2))    
%        parent_2(count_2) = indices_2(index_2);
%        count_2 = count_2 + 1;
%     end
% end
% parentIds = [parent_1' parent_2'];
% disp("hello");
end
%------------- END OF CODE --------------