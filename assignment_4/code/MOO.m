%% plot test

popSize = 50;
nGenes = 20;
nGen = 200;
% pop = randi(2, popSize, nGenes)-1
% fitness = randi(popSize, popSize, 2)
% front = randi(3, popSize,1)
% displayFronts(front, fitness, pop);

%% Single experiment
tic;
% hold on
output = NSGA(nGenes, nGen, popSize);
% hold off
toc
% show output
% output.bestFit(end)
% subplot(1,2,1);
% hold on;
% plot(output.bestFit, 'LineWidth', 2);
% plot(output.medianFit, 'LineWidth', 2);
% hold off
% legend('Best Penalty', 'Median Penalty', 'Location', 'NorthEast');
% xlabel('Generation');
% ylabel('Penalty');
% % axis([0 maxGen 0 50]);
% title('Performance on Color graph');
% subplot(1,2,2);
% plotGraph(g, kcolors, output.elite, colors);
% title('Graph with colored nodes');
% solution = output.elite';


%% Run multiple times
tic;
maxExp = 10;
% array to save the best fitness across different generation and experiments. 
aggregate_best_output = []; 
% array to save the median fitness across different generation and experiments. 
aggregate_median_output = [];

% run experiment multiple times
% parfor iExp = 1:maxExp
%     output = colorGraph(edgeList, nNodes, kcolors);
%     aggregate_best_output(iExp,:) = output.bestFit;
%     aggregate_median_output(iExp,:) = output.medianFit;
% end
% 
% % print best experiment fitness over all exp
% best_of_all_exp = aggregate_best_output(:,end);
% disp("Best experiment Distance")
% disp(min(best_of_all_exp))
% disp("Average of best experiment Distance")
% disp(mean(best_of_all_exp))
% 
% % plotting
% x = 1:length(aggregate_best_output);
% best_y = aggregate_best_output;
% median_y = aggregate_median_output;
% 
% best_medY = median(best_y);
% best_uprY = prctile(best_y,75);
% best_lwrY = prctile(best_y,25);
% 
% median_medY = median(median_y);
% median_uprY = prctile(median_y,75);
% median_lwrY = prctile(median_y,25);
% 
%                
% hFill(1) = jbfill(x,best_uprY,best_lwrY,'b'); hold on;
% % hLine = plot(x, best_medY,'Color','k','LineWidth',1); 
% plot(x, best_medY,'k--','LineWidth',1); % Dotted line to make median more clear 
% 
% hFill(2) = jbfill(x,median_uprY,median_lwrY, 'g', 'k', 0);
% % hLine2 = plot(x, median_medY,'Color','k','LineWidth',1); 
% plot(x, median_medY,'k--','LineWidth',1); % Dotted line to make median more clear 
% 
% hold off
% legend([hFill], 'Best Penalty', 'Median Penalty','Location', 'NorthEast');
% xlabel('Generation');
% ylabel('Penalty');
% % axis([0 maxGen 0 50]);
% title('Performance on Graph color');
% toc