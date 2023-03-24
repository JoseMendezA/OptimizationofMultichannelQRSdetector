% Simple arithmetic crossover
% Pick a random gene (k) after this point mix values
% Exploits idea of creating children “between” parents (hence a.k.a. arithmetic recombination)
% The crossing consists of generating two individuals between the interval [a, b], 
% which can be obtained in the following way;
% child 1 = µ*b + (1-µ)*a 
% child 2 = µ*a + (1-µ)*b
% zi =  µ*xi  + (1 - µ)* yi    where µ : 0 <= µ <= 1.
% The parameter µ can be:
% Constant: uniform arithmetical crossover
% picked at random every time


function [Offspring,R1,factor_prob_cross] = CruceR(mating_pool,V,max_iter,iter)
% The cross-over operating on the population of individuals with
% probability PC = factor_probabilidad_recombinacion € [0,1).
% In the case when rand(k) < PC for ith individual, this individual is
% chosen for cross-over operation.
Offspring = mating_pool;
factor = rand(); % where factor: 0 <= µ <= 1. Picked at random every time
R1 = rand() % Cross-over operator it depends on the random choice of real number rand(k) from the range [0,1);
  if  iter < ceil(0.8*max_iter) 
      factor_prob_cross = 0.25; 
  else
      factor_prob_cross = 0.7;
  end
    if R1 < factor_prob_cross % PC probability
       [R,~]=size(mating_pool);
       V_cross = ceil(rand*(V-1)) % starting point for Crossover (First pick a recombination point k)
            for i1 = V_cross:V % simple crossover
                t = randperm(R);
                f = reshape(t,R/2,2); % index for cross-over
                idx = 1;
                
                    for i2 = 1: R/2
                    aux1 = factor*mating_pool(f(i2,2),i1)+(1-factor)*mating_pool(f(i2,1),i1); % Child 1
                    aux2 = factor*mating_pool(f(i2,1),i1)+(1-factor)*mating_pool(f(i2,2),i1); % Child 2
                    % Generate λ new individuals
                    Offspring(idx,i1) = aux1; % Generate λ new individuals using variation operators
                    Offspring(idx+1,i1) = aux2; % Generate λ new individuals using variation operators
                    idx = idx+2;
                    end
           end
%     else
%         [Row_muta,~] = size(mating_pool); 
%         RRR = ceil(Row_muta*0.4); % RRR highest individuals for mutation operator in case the recombination operator is not used 
%         Offspring = mating_pool(1:RRR,:); % individuals for mutation operator if R1 > factor_prob_cross
   end    
end