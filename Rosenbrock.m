function [InitFunction, CostFunction, FeasibleFunction] = Rosenbrock

InitFunction = @RosenbrockInit;
CostFunction = @RosenbrockCost;
FeasibleFunction = @RosenbrockFeasible;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [MaxParValue, MinParValue, Population, OPTIONS] = RosenbrockInit(OPTIONS)

global MinParValue MaxParValue
MinParValue = -30;%-2.048;
MaxParValue = 30;%2.048;
% Initialize population
 for popindex = 1 : OPTIONS.popsize
    chrom = MinParValue + (MaxParValue - MinParValue) * rand(1,OPTIONS.numVar);
    Population(popindex).chrom = chrom;
end
OPTIONS.OrderDependent = false;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population] = RosenbrockCost(OPTIONS, Population)

% Compute the cost of each member in Population

global MinParValue MaxParValue
popsize = OPTIONS.popsize;
for popindex = 1 : popsize
    Population(popindex).cost = 0;
    for i = 1 : OPTIONS.numVar-1
        x1 = Population(popindex).chrom(i);
        x2 = Population(popindex).chrom(i+1);

        temp = 100 * (x2 - x1^2)^2 + (x1 - 1)^2;
        Population(popindex).cost = Population(popindex).cost + temp;
    end
end
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population] = RosenbrockFeasible(OPTIONS, Population)

global MinParValue MaxParValue
for i = 1 : OPTIONS.popsize
    for k = 1 : OPTIONS.numVar
        Population(i).chrom(k) = max(Population(i).chrom(k), MinParValue);
        Population(i).chrom(k) = min(Population(i).chrom(k), MaxParValue);
    end
end
return;