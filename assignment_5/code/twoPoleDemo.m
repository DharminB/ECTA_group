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
sim_output = simulation(totalSteps, initialState, scaling, elite, nFeatures, nHidden, 1)

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
