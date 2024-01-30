function [poblacion, funcion_objetivo]= poblacion_restarts(poblacion,best,RMSE_opt)
% Reinitialise Population with: 
% 1. The best solution is saved as starting point for the all member of
% population.
% 2. Replace population with population size copies the best member. 
% 3. For all but one member of population Change bits at random of the best solution.
% 4. Evaluate new individuals with this encoding.

[tamano_poblacion,L] = size(poblacion);
tamano_poblacion_temp = tamano_poblacion-1; % Save the best member
best_individual = poblacion(best,:);
poblacion_temp = repmat(best_individual,tamano_poblacion_temp,1); % Replace population

for uy = 1 : tamano_poblacion_temp
    
    % Now change that point
    md = round(rand(1,L)); 
    
    for uz = 1:L % Change bits For Alpha Coefficients and standard deviation
        if md(uz)
               poblacion_temp(uy,uz) =  poblacion_temp(uy,uz)*rand;
        end
    end
end

% Evaluate new candidates by reinitialise population
      disp('Evaluate members by reinitialise population');
      [funcion_objetivo_temp] = funcionObjetivo (poblacion_temp, tamano_poblacion_temp); % evaluate structure
      funcion_objetivo_temp = funcion_objetivo_temp.PT; % converting from struct to double
      % RMSE_opt is fitness of best individual
      % funcion_objetivo_temp is fitness of new individuals with this encoding 
      funcion_objetivo = [RMSE_opt;funcion_objetivo_temp]; 
      
poblacion = [best_individual; poblacion_temp]; % Save the best solution
                            
end
