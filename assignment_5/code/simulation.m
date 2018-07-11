function sim_output = simulation(totalSteps, initialState, scaling, ind_weights, nF, nH, visualise, NNId)
state = initialState;
Weights = ind_weights;
if visualise == 1
    clf;
    fig = figure(1);
end

for step=1:totalSteps
    onTrack = abs(state(1)) < 1.16;
    notFast = abs(state(2)) < 1.35;
    pole1Up = abs(state(3)) < pi/2;
    pole2Up = true;
%     pole2Up = abs(state(5)) < pi/2;
    failureConditions = ~[onTrack notFast pole1Up pole2Up];
    if any(failureConditions)
        break;
    else
        scaledInput = state./scaling; % Normalize state vector for ANN

        output = ActivateFFNet(scaledInput', Weights, nF, nH);
        action = output*10; % Scale to full force

        % SIMULATE RESULT
        state = cart_pole2( state, action );              

        % Visualize result (optional and slow, don't use all the time!)
        if visualise == 1
%             action
%             state(1)
%             state(2)
            cpvisual(fig, 1, state(1:4), [-3 3 0 2], action );         % Pole 1
            % cpvisual(fig, 0.5, state([1 2 5 6]), [-3 3 0 2], action ); % Pole 2
%             pause(0.005)
        end
        %
    end

end
if visualise == 1 
    close(fig);
end
sim_output.fitness = step;
end