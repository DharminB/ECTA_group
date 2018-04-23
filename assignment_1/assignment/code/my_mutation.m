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
%genesForMutation = round(1 + (p.nGenes-1)*rand(sizeOfParent(1),1))
for i=1:sizeOfChildren(1)
  % Since all genes have equal chance of mutation, we sample from a
  % uniform distribution and then use that probability value to get
  % a column index in the range of 1 to p.nGenes.
  % Refere for more info: 
  % https://de.mathworks.com/help/matlab/ref/rand.html
  geneForMutation = round(1 + (p.nGenes-1)*rand);
  % Randomly chosen values is assigned to the chosen gene from the,
  % interval of [0 27] which was used to create the initial 
  % population.
  children(i,geneForMutation) = randi([0 27]);
end
%------------- END OF CODE --------------