function [poblacion, funcion_objetivo] = Survivor_selection(mating_pool, Offspring, objective_function_pool, tamano_poblacion)
% SELECT individuals for the next generation.
% (μ + λ) SELECTION: In general, it refers to the case where the
% set of offspring and parents are merged and ranked according to (estimated)
% fitness, then the top μ are kept to form the next generation.

    % Choosing which λ offspring should go forward to the next generation
           
      [tamano_offspring,~] = size (Offspring); % Size of offspring
      
      % Evaluate new candidates 
      disp('Evaluate new candidates');
      [funcion_objetivo_offspring] = funcionObjetivo (Offspring, tamano_offspring);
      funcion_objetivo_offspring = funcion_objetivo_offspring.HT; % converting from struct to double
      
      % SELECT individuals for the next generation
      set_candidates = [mating_pool;Offspring]; % set of offspring and parents
      objective_function_survivor = [objective_function_pool; funcion_objetivo_offspring]; % merged and ranked according to (estimated) fitness
      [funcion_objetivo_temp,iden]= sort(objective_function_survivor); % Order from lowest to highest
      % top μ are kept to form the next generation
      Poblacion_temp = set_candidates(iden,:);  % ranked according to fitness
      poblacion = Poblacion_temp (1:tamano_poblacion,:); % Select μ individuals for the next generation
      funcion_objetivo = funcion_objetivo_temp (1:tamano_poblacion,:); % Save fitness for μ individuals
      
end