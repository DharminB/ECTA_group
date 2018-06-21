%% Setup

% Add path of subfolder to use the funtion
addpath('./shapematching/')
addpath('./nurbs_toolbox/')

%% Single algorithm single run single foil

% Create a NACA foil
numEvalPts = 256;                           % Num evaluation points
nacaNum = [0,0,1,2];                        % NACA Parameters
nacafoil= create_naca(nacaNum,numEvalPts);  % Create foil


% ===  Usage of algorithms ===
% output = algorithm(nacafoil, num_of_evaluations, verbose)
% nacafoil is object returned from create_naca
% verbose = 1 prints progress of algo regularly on stdout
% ============================

% output = my_ga(nacafoil, 2000, 1);
% output = my_bit_ga(nacafoil, 20000, 1);
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

eval = 200;     % should be multiple of 50
output_ga = my_ga(nacafoil, eval, 0);
output_ga_bit = my_bit_ga(nacafoil, eval, 0);
output_es = my_es(nacafoil, eval,0);
output_cmaes = my_cma_es(nacafoil, eval, 0);
output_cmaesep = my_cma_es_ep(nacafoil, eval, 0);

% show output
hold on;
xScale=50:50:eval;
plot(xScale, output_ga.bestFit, 'LineWidth', 2);

xScale=20:20:eval;
plot(xScale, output_ga_bit.bestFit, 'LineWidth', 2);

xScale=1:1:eval;
plot(xScale, output_es.bestFit, 'LineWidth', 2);

xScale=10:10:eval;
plot(xScale, output_cmaes.bestFit, 'LineWidth', 2);

xScale=10:10:eval;
plot(xScale, output_cmaesep.bestFit, 'LineWidth', 2);

hold off
legend('GA', 'GA bit','ES', 'CMAES', 'CMAES EP', 'Location', 'NorthEast');
xlabel('Evaluations');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on NACA 0012');

%% Multiple algorithm multiple run multiple foil

numEvalPts = 256;                           % Num evaluation points
nacaNum = [0 0 1 2; 5 5 2 2; 9 7 3 5];                        % NACA Parameters

eval = 20000;     % should be multiple of 50
verbose  = 0;
nExp = 20;
nFoil = 3;

algorithms = ["my_ga"; "my_bit_ga";"my_es"; "my_cma_es"; "my_cma_es_ep"];
sizes = [50, 20, 1, 10, 10];
color = ["b", "g", "r", "c", "y"];
hfill = [];
plt = [];
% run experiment multiple times
for algo_num = 1:5
    best_output = zeros(nExp*nFoil, eval/sizes(algo_num));
    for foil_num = 1 : nFoil 
        nacafoil= create_naca(nacaNum(foil_num,:),numEvalPts);
        for iExp = 1:nExp
            algorithms(algo_num,:)
            output = feval(algorithms(algo_num,:), nacafoil, eval, verbose);
            best_output((foil_num-1)*nExp + iExp,:) = output.bestFit;
        end
    end
    x = sizes(algo_num):sizes(algo_num):eval;
    median_medY = median(best_output);
    median_uprY = prctile(best_output,75);
    median_lwrY = prctile(best_output,25);
    size(best_output)

    hold on;
    [hFill(algo_num), err] = jbfill(x,median_uprY,median_lwrY, color(algo_num), 'k', 0);
    plt(algo_num) = plot(x, median_medY,color(algo_num)+"--",'LineWidth',1);
end
hold off
legend([plt], 'GA', 'GA bit', 'ES', 'CMA-ES', 'CMA-ES EP','Location', 'NorthEast');
legend([hFill], 'GA', 'GA bit', 'ES', 'CMA-ES', 'CMA-ES EP','Location', 'NorthEast');
xlabel('Evaluations');
ylabel('Fitness');
title('Performance on Foil');
