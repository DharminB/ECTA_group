%% Setup

% Add path of subfolder to use the funtion
addpath('./shapematching/')
addpath('./nurbs_toolbox/')
% Create a NACA foil
numEvalPts = 256;                           % Num evaluation points
nacaNum = [0,0,1,2];                        % NACA Parameters
nacafoil= create_naca(nacaNum,numEvalPts);  % Create foil

%% Single experiment

% output = my_ga(nacafoil);
output = my_es(nacafoil);
% output = my_cma_es(nacafoil);
% output = my_cma_es_ep(nacafoil);

% show output
output.bestFit(end)
subplot(1,2,1);
hold on;
plot(output.bestFit, 'LineWidth', 2);
plot(output.medianFit, 'LineWidth', 2);
hold off
legend('Best Fitness', 'Median Fitness', 'Location', 'NorthEast');
xlabel('Evaluations');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on NACA 0012');
subplot(1,2,2);
plotFoil(nacafoil, output.elite);
title('wing of best');


%% Multiple experiment

output = my_ga(nacafoil);
output2 = my_es(nacafoil);
% output = my_cma_es(nacafoil);
% output = my_cma_es_ep(nacafoil);

% show output
output.bestFit(end)
hold on;
xScale=50:50:2000;
plot(xScale, output.bestFit, 'LineWidth', 2);

xScale=4:4:2000;
plot(xScale, output2.bestFit, 'LineWidth', 2);

hold off
legend('GA', 'ES', 'Location', 'NorthEast');
xlabel('Evaluations');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on NACA 0012');

