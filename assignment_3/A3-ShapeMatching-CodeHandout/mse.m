function fitness = mse(pop, nacafoil)
    numEvalPts = size(nacafoil, 2);
    popSize = size(pop,1);
    fitness = zeros(popSize,1);
    for iInd = 1 : popSize
        % Extract spline representation of foil (with the same number of evaluation
        % points as the NACA profile
        [foil, nurbs] = pts2ind(pop(iInd,:)',numEvalPts);

        % Calculate pairwise error
        half = round(nacafoil/2);
        [~,errorTop] =    dsearchn(nacafoil(:,1:end/2)'    ,foil(:,1:end/2)');
        [~,errorBottom] = dsearchn(nacafoil(:,1+end/2:end)',foil(:,1+end/2:end)');

        % Total fitness (mean squared error)
        fitness(iInd) = mean([errorTop.^2; errorBottom.^2]);
    end
end