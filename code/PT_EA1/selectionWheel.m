function [mating_pool,objective_function_pool] = selectionWheel (funcion_objetivo, tamano_poblacion, poblacion)

%The roulette wheel algorithm μ: parents into a mating pool λ: number of
%select members from the set of μ Given the cumulative probability
%distribution "a" and assuming we wish to select λ members of the mating
%pool A random value is chosen M-times in order to select M individual to
%the new population. If randomly chosen value is inside the range [min_i
%max_i) then ith individual is selected to the new population

rng shuffle

OF = funcion_objetivo; % Objective function.
a = zeros(1,tamano_poblacion); % Vector of cumulative probability distribution
[~,L] = size(poblacion);

    for i1 = 1:tamano_poblacion
        FF(i1) = 1/OF(i1); % fitness function
    end
    
    GF = sum(FF); % Global Fitness.
    
        for i2 = 1: tamano_poblacion
            rfitness(i2) = FF(i2)/GF; % Sector size on roulette wheel.

                if i2 == 1
                a(1,i2) = rfitness(i2); % First ai [0,max_i)
                else
                    a(1,i2) = a(1,(i2-1))+rfitness(i2); % calculate the cumulative probability distribution 
                                                        % [a1, a2, . . . ,aμ], this implies aμ = 1.
                end
        end

            gamma = round(tamano_poblacion*0.7); %λ: number of select members from the set of μ
            
            if rem(gamma,2)~= 0
                gamma = gamma + 1; % Convert to even number (for cross-over operator).
            end

current_member = 1; % counter number of select λ  
mating_pool = zeros(gamma,L); % offspring

        while  current_member <= gamma % spinning a one-armed roulette wheel
            RW = rand(); % A random value [0,1) is chosen gamma-times in order to selected gamma individual 
                         %to the new population   
            counter = 1; % index into cumulative probability distribution

            while a(1,counter) < RW % If randomly chosen value is inside the range [min_i max_i) then ith individual is selected to the new population
                     counter = counter + 1; % 
            end
            mating_pool(current_member,:) = poblacion(counter,:); % offspring: individual are selected to the new population
            OF_Temp(current_member,1) = OF(counter,1);
            current_member = current_member + 1; 
        end
        
%Order from highest to lowest for replacement in crossover
[objective_function_pool,idx]= sort(OF_Temp);
mating_pool = mating_pool(idx,:);
        
end


