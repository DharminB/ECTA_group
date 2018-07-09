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
fig = figure(1);
totalSteps = 1000;
initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
state = initialState;
p.simParams.force = 10;
totalEpisodes = 1000;

nInputs = 1; 
nFeatures = 6;
nHidden = 5; 
nOutputs = 1;
nNode = nFeatures+nHidden+nOutputs;
nGenes = (nFeatures*nHidden) + (nHidden*nOutputs);
popSize = 200;
sp = 2;
crossProb = 0.6;
mutProb = 0.4;
%% Train the network
% Create a population
% for iPop = 1:popSize
%     pop(iPop,:) = randn(1,nGenes)*0.1;
% end
pop = randn(popSize,nGenes)*0.1;
fitness = zeros(1,popSize);

%Run for 200 episodes
for episode=1:totalEpisodes
    % Run this for each individual to get its fitness
    for iPop = 1:popSize
        Weights = pop(iPop,:);
        for step=1:totalSteps
            flag = 0;
            % Check that all states are legal
            onTrack = abs(state(1)) < 2.16;
%             onTrack = abs(state(1)) < 1.16;
            notFast = abs(state(2)) < 1.35;
            pole1Up = abs(state(3)) < pi/2;
            pole2Up = true;
        %     pole2Up = abs(state(5)) < pi/2;
            failureConditions = ~[onTrack notFast pole1Up pole2Up];
            if any(failureConditions)
                flag = 1;
                fitness(1,iPop) = step;
                break;
            else % Do the next time step
                % ACTION SELECTION [your code goes here]
                scaledInput = state./scaling; % Normalize state vector for ANN
                
                % Output should be the response of your neural network. Here I just 
                % use a random number between 0 and 1. Put your ANN code here. 
                % Output should be between -1 (full force left) and 1 (full force right)
%                 output = 2*(rand(1)-0.5);
                output = ActivateFFNet(scaledInput', Weights);
                action = output*p.simParams.force; % Scale to full force
                
                % SIMULATE RESULT
                % Take action and return new state:
                state = cart_pole2( state, action );              

                % Visualize result (optional and slow, don't use all the time!)
                %clf
%                 cpvisual(fig, 1, state(1:4), [-3 3 0 2], action );         % Pole 1
%                 cpvisual(fig, 0.5, state([1 2 5 6]), [-3 3 0 2], action ); % Pole 2
%                 pause(0.02);
            end

        end
        state = initialState;
        close(fig);
        fig = figure(1);
    end
    parentIds = selection(fitness, popSize, sp);
    children = crossover(pop, parentIds, crossProb, nGenes);
    mut_children = mutation(children, nGenes, mutProb);
    eliteIds  = elitism(fitness);
    newPop    = [pop(eliteIds,:); mut_children];
    pop       = newPop(1:popSize,:);
    disp("Best Fitness");
    disp("Episode");
    disp(episode);
    disp(fitness(eliteIds));
    fitness
end
%%
Weights = pop(eliteIds,:);
for step=1:totalSteps
    flag = 0;
    % Check that all states are legal
    onTrack = abs(state(1)) < 2.16;
%     onTrack = abs(state(1)) < 1.16;
    notFast = abs(state(2)) < 1.35;
    pole1Up = abs(state(3)) < pi/2;
    pole2Up = true;
%     pole2Up = abs(state(5)) < pi/2;
    failureConditions = ~[onTrack notFast pole1Up pole2Up];
    if any(failureConditions)
        flag = 1;
        fitness(1,iPop) = step; break;
    else % Do the next time step
        % ACTION SELECTION [your code goes here]
        scaledInput = state./scaling; % Normalize state vector for ANN

        % Output should be the response of your neural network. Here I just 
        % use a random number between 0 and 1. Put your ANN code here. 
        % Output should be between -1 (full force left) and 1 (full force right)
%       output = 2*(rand(1)-0.5);
        output = ActivateFFNet(scaledInput', Weights);
        action = output*p.simParams.force; % Scale to full force

        % SIMULATE RESULT
        % Take action and return new state:
        state = cart_pole2( state, action );              

        % Visualize result (optional and slow, don't use all the time!)
        %clf
        cpvisual(fig, 1, state(1:4), [-3 3 0 2], action );         % Pole 1
%                 cpvisual(fig, 0.5, state([1 2 5 6]), [-3 3 0 2], action ); % Pole 2
        pause(0.02);
    end
    disp("Done");
    step
    state
end
