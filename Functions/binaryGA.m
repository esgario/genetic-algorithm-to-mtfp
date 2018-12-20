function [BestFitness, BestConstraints, Xbest, A] = binaryGA(Np, Ni, Nj, Ngen, SocMatrix, ReqMatrix, DepVector)

% INPUT
% Np - number of individuals/particles of the genetic algorithm
% Ni - number of individuals regarding the allocation problem
% Nj - number of groups regarding the allocation problem
% Ngen - number of gererations
% SocMatrix - sociometric matrix
% ReqMatrix - requirements matrix
% DepVector - department vector of each individual
%
% OUTPUT
% BestFitness
% BestConstraints
% Xbest - best individual
% A - best vector solution
% BestChart

%% Variables
bits = Nj;
BestConstraints = 0;
BestFitness = -inf;

% Dynamic Alpha
alpha = 1/Ni;
disp(sprintf('Alpha: %.6f',alpha));

%% 1. Init Vector Particle Position
X = zeros(Np, Ni);
X = initParticles(X, bits);

%% 2. While stop criterion is not met, do: 
for j=1:Ngen
    
    %%% 2.1 Evaluate each individual of the population
    for i=1:Np
        A = convertToSolutionMatrix(X(i,:), Ni, Nj);
        cohesion(i) = ComputeCohesion(A, SocMatrix, ReqMatrix, Ni, Nj);
        constraints(i) = CompareSolutionsAndRequirements(A, ReqMatrix, DepVector);
    end
    Cost = cohesion - constraints;
    [BestFitnessAux, index] = max(Cost);
    
    if BestFitnessAux > BestFitness
        BestFitness = BestFitnessAux;
        BestCohesion = cohesion(index);
        BestConstraints = constraints(index);
        Xbest = X(index,:);
    end
    
    %%% 2.2 Select the fittest individuals (torneio)
    X = tournament(X, Cost);
    
    %%% 2.3 Create new individuals by operators: crossover and mutation.
    X = crossoverAndMutation(X, alpha, bits);
    
    %%% Plot
    if mod(j,1) == 0
        disp(sprintf('%d - Fitness:%.4f, Cohesion:%.4f, Penalty:%.2f | %.4f, %.2f',j,BestFitness,BestCohesion,BestConstraints,cohesion(index),constraints(index)));
    end
    
end
A = convertToSolutionMatrix(Xbest, Ni, Nj);

% ------------ FUNCTIONS ------------- %
function f = tournament(X,Cost)
ni = size(X,1);

for i=1:ni
    index = randi(ni,2,1);
    ma = X(index(1),:);
    pa = X(index(2),:);
    
    if Cost(index(1)) > Cost(index(2))
        f(i,:) = ma;
    else
        f(i,:) = pa;
    end
end

function f = crossoverAndMutation(X, alpha, bits)
[np,ni] = size(X);
f = X;

for p=1:2:np
    for i=1:ni
        % Crossover
        if rand < 0.2
            f(p,i) = X(p+1,i);
            f(p+1,i) = X(p,i);
        end
        
        % Mutation
        for k=0:1
            ii = p+k;
            if rand < alpha
                f(ii,i) = bitset(0,randi(bits),1);
            end
        end
    end
end

function X = initParticles(X, bits)
[np,ni] = size(X);
for p=1:np
    for i=1:ni
        X(p,i) = bitset(X(p,i),randi(bits),1);
    end
end

function A = convertToSolutionMatrix(Z, ni, nj)
A = zeros(ni,nj);
for i=1:ni
    for j=1:nj
        A(i,j) = bitget(Z(1,i),j);
    end
end