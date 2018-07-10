function sim_output = simulation_rnn(totalSteps, initialState, scaling, ind_weights, nF, nH, visualise)
state = initialState;
Weights = get_rnn_weight_matrix(ind_weights, nF, nH);
if visualise == 1
    clf;
    fig = figure(1);
end
nodeAct = zeros(1,nF+nH);
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
        nodeAct(1:nF) = scaledInput([1 3 5]);
        % RNNet
        output = ActivateRNNet(nodeAct, Weights, nF, nH);
        action = output.action*10; % Scale to full force
        nodeAct = output.nodeAct;

        % SIMULATE RESULT
        state = cart_pole2( state, action );              

        % Visualize result (optional and slow, don't use all the time!)
        if visualise == 1
            cpvisual(fig, 1, state(1:4), [-3 3 0 2], action );         % Pole 1
            % cpvisual(fig, 0.5, state([1 2 5 6]), [-3 3 0 2], action ); % Pole 2
%             pause(0.005)
        end
    end

end
if visualise == 1 
    close(fig);
end
sim_output.fitness = step;
end