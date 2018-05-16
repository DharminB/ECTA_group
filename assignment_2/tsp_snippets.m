%% Read file
cityData = importdata('cities.csv');
nCities = 100;
coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc

%% Look up distance for one individual
distMat = squareform(pdist(coords')); % Precalculate Distance Matrix

%% Run once and plot (best and median, best path)
% Run one experiment
output = my_tsp(distMat);

% show output
output.bestArray(end)
subplot(1,2,1);
plot([output.bestArray; output.medianArray]', 'LineWidth', 2);
legend('Best Fitness', 'Median Fitness', 'Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on TSP');
subplot(1,2,2);
plotTsp(output.elite, coords);
title('map of best');

%% Run multiple times

maxExp = 30;
% array to save the best fitness across different generation and experiments. 
aggregate_best_output = []; 
% array to save the median fitness across different generation and experiments. 
aggregate_median_output = [];

% run experiment multiple times
parfor iExp = 1:maxExp
   output = my_tsp(distMat);
   aggregate_best_output(iExp,:) = output.bestArray;
   aggregate_median_output(iExp,:) = output.medianArray;
end

% print best experiment fitness over all exp
best_of_all_exp = aggregate_best_output(:,end);
disp("Best experiment Distance")
disp(min(best_of_all_exp))

% plotting
x = 1:length(aggregate_best_output);
best_y = aggregate_best_output;
median_y = aggregate_median_output;

best_medY = median(best_y);
best_uprY = prctile(best_y,75);
best_lwrY = prctile(best_y,25);

median_medY = median(median_y);
median_uprY = prctile(median_y,75);
median_lwrY = prctile(median_y,25);

               
hFill(1) = jbfill(x,best_uprY,best_lwrY,'b'); hold on;
% hLine = plot(x, best_medY,'Color','k','LineWidth',1); 
plot(x, best_medY,'k--','LineWidth',1); % Dotted line to make median more clear 

hFill(2) = jbfill(x,median_uprY,median_lwrY, 'g', 'k', 0);
% hLine2 = plot(x, median_medY,'Color','k','LineWidth',1); 
plot(x, median_medY,'k--','LineWidth',1); % Dotted line to make median more clear 

hold off
legend([hFill], 'Best Fitness', 'Median Fitness','Location', 'NorthEast');
xlabel('Generation');
ylabel('Fitness');
% axis([0 maxGen 0 50]);
title('Performance on TSP');
