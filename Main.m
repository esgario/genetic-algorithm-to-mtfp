clear; clc;

addpath('Functions/','Datasets/');

%% Dataset --------------------------------------- %%
dataset = 7; % select dataset: [1,...,7]

% Import sociometric matrix
SocMatrix = xlsread(sprintf('SM%d.xlsx',dataset));

% Import requirements matrix
ReqMatrix = xlsread(sprintf('RM%d.xlsx',dataset));

% yield department vector
d = sum(ReqMatrix,2);
DepVector = [];
for i=1:length(d)
    DepVector = [ DepVector; i*ones(ceil(d(i)),1) ];
end

%% Variables ------------------------------------- %%

% Alocation problem
nIndividuals = size(SocMatrix,1);
nGroups = size(ReqMatrix,2);

% Genetic Algorithm
alpha = 20;
maxIterations = round(alpha*nIndividuals*log(nGroups));
Np = 50;

%% Genetic Algorithm ----------------------------- %%
nExec = 20;
for i=1:nExec
    tic;
    fprintf('##### Exec.%d\n',i);
    
    [BestFitness(i), BestConstraints(i), Xbest, A] = binaryGA(Np,...
        nIndividuals, nGroups, maxIterations, SocMatrix, ReqMatrix, DepVector);
    
    fprintf('Fitness: %.4f\n',BestFitness(i));
    TimeElapsed(i) = toc;
end

fprintf('\n##### Results:\nTime: %.2fs Max: %.4f, Mean: %.4f, Std: %.4f, Min: %.4f\n',...
mean(TimeElapsed), max(BestFitness), mean(BestFitness), std(BestFitness), min(BestFitness));
