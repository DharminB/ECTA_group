%% Setup

% Add path of subfolder to use the funtion
addpath('./shapematching/')
addpath('./nurbs_toolbox/')
% Create a NACA foil
numEvalPts = 256;                           % Num evaluation points
nacaNum = [0,0,1,2];                        % NACA Parameters
nacafoil= create_naca(nacaNum,numEvalPts);  % Create foil

%% Single algorithm single run single foil

% ===  Usage of algorithms ===
% output = algorithm(nacafoil, num_of_evaluations, verbose)
% nacafoil is object returned from create_naca
% verbose = 1 prints progress of algo regularly on stdout
% ============================

% output = my_ga(nacafoil, 2000, 1);
% output = my_es(nacafoil, 2000, 1);
output = my_cma_es(nacafoil, 2000, 1);
% output = my_cma_es_ep(nacafoil, 2000, 1);

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


%% Multiple algorithm single run single foil

eval = 2000;
output_ga = my_ga(nacafoil, eval, 0);
output_es = my_es(nacafoil, eval,0);
output_cmaes = my_cma_es(nacafoil, eval, 0);
output_cmaesep = my_cma_es_ep(nacafoil, eval, 0);

% show output
hold on;
xScale=50:50:2000;
plot(xScale, output_ga.bestFit, 'LineWidth', 2);

xScale=1:1:2000;
plot(xScale, output_es.bestFit, 'LineWidth', 2);

xScale=10:10:2000;
plot(xScale, output_cmaes.bestFit, 'LineWidth', 2);

xScale=10:10:2000;
plot(xScale, output_cmaesep.bestFit, 'LineWidth', 2);

hold off
legend('GA', 'ES', 'CMAES', 'CMAES EP', 'Location', 'NorthEast');
xlabel('Evaluations');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on NACA 0012');

