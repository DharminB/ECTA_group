%% single experiment

popSize = 100;
nGenes = 20;
nGen = 100;
plotgif = 0;
use_nsga2 = 1
if plotgif == 1
    gif('myfile.gif','DelayTime',1/10,'frame',gcf);
end
tic;
output = my_ga(nGenes, nGen, popSize, use_nsga2, plotgif);
toc
displayFronts(output.front, output.fitness, output.pop);
% output.front==1
hold off;

%% Run multiple times
tic;
maxExp = 3;
popSize = 1000;
nGenes = 20;
nGen = 100;
plotgif = 0;
if plotgif == 1
    gif('myfile.gif');
end

algos = [0 1];
% run experiment multiple times
for algo_num = algos
    sum = 0;
    for iExp = 1:maxExp
        iExp
        tic;
        output = my_ga(nGenes, nGen, popSize, algo_num, plotgif);
        sum = sum + toc;
    end
    disp("Algo " + algo_num + " takes " + sum/maxExp + " seconds on average")
end

%% Single exp comparision for popSize
nGenes = 20;
plotgif = 0;
use_nsga2 = 1
if plotgif == 1
    gif('myfile.gif');
end

subplot(1,2,1);
tic;
popSize = 100;
nGen = 100;
output = my_ga(nGenes, nGen, popSize, use_nsga2, plotgif);
toc
displayFronts(output.front, output.fitness, output.pop);

subplot(1,2,2);
tic;
popSize = 10;
nGen = 1000;
output = my_ga(nGenes, nGen, popSize, use_nsga2, plotgif);
toc
displayFronts(output.front, output.fitness, output.pop);
hold off;

%%
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