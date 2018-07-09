%% This is an example call to the simulator
addpath('./simulator/')
%% Here is how a state is defined:
%   state = [ x           <- the cart position
%             x_dot       <- the cart velocity
%             theta       <- the angle of the pole
%             theta_dot   <- the angular velocity of the pole.
%             theta2      <- the angle of the 2nd pole
%             thet2a_dot  <- the angular velocity of the 2nd pole.
%           ]
%% GA
initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 10;
maxGen = 1000;
totalSteps = 1000;
nFeatures = 6;
nHidden = 8;
output = my_ga(initialState, scaling, popSize, maxGen, totalSteps, nFeatures, nHidden);
output.bestFitness
plot(output.bestFitness', 'LineWidth', 2);
legend('Best Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on single cart pole');

elite = output.elite;
sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 0)

%% ES
initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 1;
maxGen = 100;
totalSteps = 1000;
nFeatures = 6;
nHidden = 12;
output = my_es(initialState, scaling, popSize, maxGen, totalSteps, nFeatures, nHidden);
output.bestFitness
plot(output.bestFitness', 'LineWidth', 2);
legend('Best Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on single cart pole');

elite = output.elite;
sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 0)

%% Check matrix
clear;
initialState = [0 0 .037 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
totalSteps = 1000;
nFeatures = 6;

% for ga
nHidden = 8;
load('../ga.mat');

% for es
% nHidden = 12;
% load('../es.mat');
% mat = es_mat;

[iLimit, jLimit] = size(mat)
elite = zeros(1, nFeatures*nHidden + nHidden);
count = 1;
for i = 1:iLimit
    for j = 1:jLimit
        if mat(i, j) ~= 0
            elite(count) = mat(i, j);
            count = count + 1;
        end
    end
end
elite;

sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 1)

