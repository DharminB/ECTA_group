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
clear;
initialState = [0 0 .017 0 0.017 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 10;
maxGen = 100;
totalSteps = 1000;
nFeatures = 6;
nHidden = 8;
NNId = 1;
output = my_ga(initialState, scaling, popSize, maxGen, totalSteps, nFeatures, nHidden, NNId);
output.bestFitness
plot(output.bestFitness', 'LineWidth', 2);
legend('Best Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on single cart pole');

elite = output.elite;
% sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 1)

%% ES
clear;
initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 1;
maxGen = 50;
totalSteps = 1000;
nFeatures = 4;
nHidden = 1;
NNId = 1; % For FFNet
output = my_es(initialState, scaling, popSize, maxGen, totalSteps, nFeatures, nHidden, NNId);
output.bestFitness
plot(output.bestFitness', 'LineWidth', 2);
legend('Best Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on single cart pole');

elite = output.elite;
sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 0, NNId)

%% ES with RNN
clear;
initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 1;
maxGen = 1000;
totalSteps = 1000;
nFeatures = 3;
nHidden = 5;
NNId = 0; % For RNN
output = my_es(initialState, scaling, popSize, maxGen, totalSteps, nFeatures, nHidden, NNId);
output.bestFitness;
plot(output.bestFitness', 'LineWidth', 2);
legend('Best Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on single cart pole');

elite = output.elite;
% sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 0, NNId)
sim_output = simulation_rnn(totalSteps, initialState, scaling, elite, nFeatures+1, nHidden, 0)

%% GA with RNN
clear
initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 10;
maxGen = 500;
totalSteps = 1000;
nFeatures = 3;
nHidden = 5;
NNId = 0; % For RNN
output = my_ga(initialState, scaling, popSize, maxGen, totalSteps, nFeatures, nHidden, NNId);
output.bestFitness;
plot(output.bestFitness', 'LineWidth', 2);
legend('Best Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on single cart pole');

elite = output.elite;
% sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 0, NNId)
sim_output = simulation_rnn(totalSteps, initialState, scaling, elite, nFeatures+1, nHidden, 0)

%% ESP
clear;
initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 10;
maxGen = 100;
totalSteps = 1000;
nFeatures = 3;
nHidden = 5;
nTrials = 5;
output = my_esp(initialState, scaling, popSize, maxGen, totalSteps, nTrials, nFeatures, nHidden);
output.bestFitness;
plot(output.bestFitness', 'LineWidth', 2);
legend('Best Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
title('Performance on single cart pole');

elite = output.elite;
% sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 0, NNId)
sim_output = simulation_esp(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 0)

%% Mutiple experiment
nExp = 10;
initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 1;
maxGen = 100;
totalSteps = 1000;
nFeatures = 4;
nHidden = 1;
NNId = 1;
fitness_esp = zeros(nExp, maxGen);

for iExp=1:nExp
    output = my_es(initialState, scaling, popSize, maxGen, totalSteps, nFeatures, nHidden, NNId);
    fitness_esp(iExp,:) = output.bestFitness;
end

% plotting
x = 1:size(fitness_esp, 2);

best_medY = median(fitness_esp);
best_uprY = prctile(fitness_esp,75);
best_lwrY = prctile(fitness_esp,25);

[hFill, hi] = jbfill(x,best_uprY,best_lwrY,'b'); hold on;
% hLine = plot(x, best_medY,'Color','k','LineWidth',1); 
plot(x, best_medY,'k--','LineWidth',1); % Dotted line to make median more clear 


hold off
legend(hFill, 'Median Fitness','Location', 'NorthEast');
legend('Best Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on single cart pole');


%% Mutiple experiment 2 pole
clear;
nExp = 2;
initialState = [0 0 .017 0 0.017 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 10;
maxGen = 100;
totalSteps = 1000;
nFeatures = 6;
nHidden = 8;
NNId = 1;
fitness_esp = zeros(nExp, maxGen);

for iExp=1:nExp
    output = my_ga(initialState, scaling, popSize, maxGen, totalSteps, nFeatures, nHidden, NNId);
    fitness_esp(iExp,:) = output.bestFitness;
end

% plotting
x = 1:size(fitness_esp, 2);

best_medY = median(fitness_esp);
best_uprY = prctile(fitness_esp,75);
best_lwrY = prctile(fitness_esp,25);

[hFill, hi] = jbfill(x,best_uprY,best_lwrY,'b'); hold on;
% hLine = plot(x, best_medY,'Color','k','LineWidth',1); 
plot(x, best_medY,'k--','LineWidth',1); % Dotted line to make median more clear 

hold off
legend(hFill, 'Median Fitness','Location', 'NorthEast');
legend('Best Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on double cart pole');

%% Multiple experiment ESP vs RNN
clear;
nExp = 10;

initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
popSize = 10;
maxGen = 100;
totalSteps = 1000;
nFeatures = 3;
nHidden = 5;
nTrials = 5;
fitness_esp = zeros(nExp, maxGen);

for iExp=1:nExp
    output = my_esp(initialState, scaling, popSize, maxGen, totalSteps, nTrials, nFeatures, nHidden);
    fitness_esp(iExp,:) = output.bestFitness;
end
%%
popSize = 10;
maxGen = 500;
totalSteps = 1000;
nFeatures = 3;
nHidden = 5;
NNId = 0; % For RNN
fitness = zeros(nExp, maxGen);

for iExp=1:nExp
    output = my_ga(initialState, scaling, popSize, maxGen, totalSteps, nFeatures, nHidden, NNId);
    fitness(iExp,:) = output.bestFitness;
end
%% plotting side by side
subplot(1,2,1);
x = 1:size(fitness_esp, 2);

best_medY = median(fitness_esp);
best_uprY = prctile(fitness_esp,75);
best_lwrY = prctile(fitness_esp,25);

[hFill, hi] = jbfill(x,best_uprY,best_lwrY,'b'); hold on;
% hLine = plot(x, best_medY,'Color','k','LineWidth',1); 
plot(x, best_medY,'k--','LineWidth',1); % Dotted line to make median more clear 

subplot(1,2,2);
% plotting
x = 1:size(fitness, 2);

best_medY = median(fitness);
best_uprY = prctile(fitness,75);
best_lwrY = prctile(fitness,25);

[hFill2, hi] = jbfill(x,best_uprY,best_lwrY,'g'); hold on;
% hLine = plot(x, best_medY,'Color','k','LineWidth',1); 
plot(x, best_medY,'k--','LineWidth',1); % Dotted line to make median more clear 

%% plotting in one plot
x = 1:size(fitness_esp, 2);

best_medY = median(fitness_esp);
best_uprY = prctile(fitness_esp,75);
best_lwrY = prctile(fitness_esp,25);

[hFill, hi] = jbfill(x,best_uprY,best_lwrY,'b'); hold on;
% hLine = plot(x, best_medY,'Color','k','LineWidth',1); 
plot(x, best_medY,'k--','LineWidth',1); % Dotted line to make median more clear 

% plotting
x = 1:size(fitness, 2);

best_medY = median(fitness);
best_uprY = prctile(fitness,75);
best_lwrY = prctile(fitness,25);

[hFill2, hi] = jbfill(x,best_uprY,best_lwrY,'g'); hold on;
% hLine = plot(x, best_medY,'Color','k','LineWidth',1); 
plot(x, best_medY,'k--','LineWidth',1); % Dotted line to make median more clear 

legend([hFill hFill2], 'ESP', 'GA RNN','Location', 'NorthEast');
% legend('ESP', 'GA RNN', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on double cart pole');


%% Check matrix
clear;
initialState = [0 0 .037 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
totalSteps = 1000;
nFeatures = 6;
NNId = 1;

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

sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 1, NNId)

