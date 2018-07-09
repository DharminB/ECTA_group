%% Display Fronts
% 
function fig = displayFrontsWithMarkers(front, fitness, pop, greenIndices)
%displayFronts - Displays pareto fronts in leading ones/trailing zeros
% 
%
% Syntax:  [output1,output2] = function_name(input1,input2,input3)
%
% Inputs:
%    front   - [N X 1] - The front which an individual belongs (1st,2nd,...)
%    fitness - [N X 2] - Fitness values for each objective
%    pop     - [N X M] - Genome of length M of each of the N individuals
%
% Outputs:
%    fig     - handle  - figure handle
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Oct 2017; Last revision: 14-Jun-2018

nGenes = size(pop,2);
popSize= size(pop,1);

hold off;
nFront = max(front); colors = parula(nFront);
for iFront=1:nFront
    h = plot(fitness((front==iFront),1),fitness((front==iFront),2));
    set(h,'LineStyle','--','Color',colors(iFront,:),'Marker','o'...
         ,'MarkerFaceColor', colors(iFront,:),'MarkerSize',25)
    
    hold on
    if iFront ==1
        text(fitness((front==iFront),1)+0.35,...
            fitness((front==iFront),2)-(0.25*~mod(iFront,2)),...
            num2str(pop( (front==iFront),:)))
    end
%         text(fitness((front==iFront),1)+0.35,...
%             fitness((front==iFront),2)-(0.25*~mod(iFront,2)),...
%             num2str(pop( (front==iFront),:)))
end
xlabel('Leading Zeros');ylabel('Trailing Ones');

plot(fitness(greenIndices, 1), fitness(greenIndices, 2), 'og', 'MarkerSize', 12)
somearray = 1:popSize;
redIndices = somearray(~ismember(somearray,greenIndices));
plot(fitness(redIndices, 1), fitness(redIndices, 2), 'xr', 'MarkerSize', 12)

axis([-0.5 nGenes+0.5 -0.5 nGenes+0.5]); hold off;
title('Solutions and Fronts');
grid on;


fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14)
set(gca,'FontSize',18);