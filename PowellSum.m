function [InitFunction, CostFunction, FeasibleFunction] = PowellSum

InitFunction = @PowellSumInit;
CostFunction = @PowellSumCost;
FeasibleFunction = @PowellSumFeasible;
return;
%%%%% As per details in benchmark functions in pdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [MaxParValue, MinParValue, Population, OPTIONS] = PowellSumInit(OPTIONS)

global MinParValue MaxParValue

MinParValue = -1;
MaxParValue = 1;
% Initialize population
for popindex = 1 : OPTIONS.popsize
    chrom = MinParValue + (MaxParValue - MinParValue) * rand(1,OPTIONS.numVar);
    Population(popindex).chrom = chrom;
end
OPTIONS.OrderDependent = false;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population] = PowellSumCost(OPTIONS, Population)

% Compute the sphere cost function of each member in Population

global MinParValue MaxParValue
popsize = OPTIONS.popsize;
for popindex = 1 : popsize
    Population(popindex).cost = 0;
    
    for i = 1 : OPTIONS.numVar
        x = Population(popindex).chrom(i);
        
        Population(popindex).cost = Population(popindex).cost + ((abs(x))^(i+1));
    end
end
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population] = PowellSumFeasible(OPTIONS, Population)

global MinParValue MaxParValue
for i = 1 : OPTIONS.popsize
    for k = 1 : OPTIONS.numVar
        Population(i).chrom(k) = max(Population(i).chrom(k), MinParValue);
        Population(i).chrom(k) = min(Population(i).chrom(k), MaxParValue);
    end
end
return;