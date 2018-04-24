function children  = my_mutation(children, p)
%Mutation - Make random changes in the child population
% - Point mutation:
%   1) Determine which genes will be mutated -- all have an equal chance
%   2) Change every gene chosen for mutation to another random value
%
% Syntax:  children  = my_mutation(children, p);
%
% Inputs:
%    children   - [M X N] - Population of M individuals
%    p          - _struct - Hyperparameter struct
%     .mutProb              - Chance per gene of performing mutation
%
% Outputs:
%    children   - [M X N] - New population of M individuals
%
% See also: selection, crossover, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%------------- BEGIN CODE --------------

%% No mutation happening, can you do better?
children = children; 
sizeOfChildren = size(children);
for i=1:sizeOfChildren(1)
    for j=1:p.nGenes
        % generate a random float(0 to 1) for every gene in a child
        random_number = rand(1);
        if random_number < p.mutProb
            % Randomly chosen values is assigned to the chosen gene from the,
            % interval of [0 27] which was used to create the initial 
            % population.
            children(i,j) = randi([0 27]);
        end        
    end
end
%------------- END OF CODE --------------