clc
global data 
data = init;
fprintf("finished data loading");

options = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping});
options.InitialPopulationRange = [0,0,0;pi,pi,pi];
options.PopulationSize = 50;
options.MaxStallGenerations = 20;
FitnessFcn = @corr;
numberOfVariables = 3;  % Number of design variables
LB = -3.1415*ones(1,3);  % Lower bound
UB = 3.1415*ones(1,3);  % Upper bound
rng('default')
[x,fval,exitFlag,Output,population,scores] = ga(FitnessFcn,numberOfVariables,[],[],[],[],LB,UB,[],options)
disp(x);