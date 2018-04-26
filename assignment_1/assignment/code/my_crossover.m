function children  = my_crossover(pop, parentIds, p)
%Crossover - Creates child solutions by combining genes of parents
% - Single Point Crossover:
%   1) For each set of parents:
%   2) Determine whether or not to perform crossover (p.xoverChance)
%   3) If not, take first parent as child
%   4) If yes, choose random point along genome and:
%   5) Create child from genes behind point from parent A and in front of
%   that point from parent B
%
% Syntax:  children  = crossover(pop, parentIds, p)
%
% Inputs:
%    pop        - [M X N] - Population of M individuals
%    parentIds  - [M X 2] - Parent pair indices
%    p          - _struct - Hyperparameter struct
%     .crossProb            - Chance of performing crossover
%
% Outputs:
%    children   - [M X N] - New population of M individuals
%
% See also: selection, mutation, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%------------- BEGIN CODE --------------

%% No crossover happening, can you do better?
% children = pop( parentIds(:,1) ,:);
children = [];
sizeOfParent = size(parentIds);
for i = 1:sizeOfParent(1)
    % create random number to decide whether to crossover or not
    random_number = rand(1);
    if random_number < p.crossProb
        % randomly generate a crossover point where the gene will be spliced
        crossPoint = randi(p.nGenes);
        parentA = pop(parentIds(i,1),:);
        parentB = pop(parentIds(i,2),:);
        % merge the parents genes at crosspoint
        child = [parentA(1:crossPoint) parentB(1+crossPoint:end)];
    else
        % assign first parent's gene to child without change
        child = pop(parentIds(i,1),:);
    end
    % add child's gene to genepool
    children = vertcat(children, child);
end
%------------- END OF CODE -------------