% This is the main script
% Evolutionary Algorithm With Pan and Tompkins Detector

% perform singlechannel detections
% singlechannel_detection_performance_main; 

% This script allows to obtain the best QRS complex detection performances
% first_performance_singlechannel;

%%  Evolutionary algorithm [EA]
tic
%% Hyperparameter configuration
 tamano_poblacion = 18; % Population size
 L = 27; % Chromosome length
 V = 27; %V: Number of independent variables in an optimized task.
	 % In this case study, each chromosome is represented for 27 variable using 1 gene (real number representation)
 
 I_beta  = [-1.5 3]; 	  % Threshol vector to find the optimal beta within a search space;
 I_alpha = [0 3.5];       % Scaled in the search range (view previous line comment).

 mejorRMSE = 1000; %The best RMSE value: 19.9883 for DPD = 0.00141
                   %Represents the best detection performance using the
                   %proposed multi-channel detector for PT
      
% Parameters of Terminate conditions of the algorithm 
 iter = 0;
 parar = false;
 r = 0;
 max_iter = 20; % Fix Time by Maximun number of generations
 
 x1 = zeros(1,L-1); % Optimal data coefficients
 
 % Add code folder to the search path
addpath(pwd); 

%Creation of the population arrangement with the initial population chosen randomly 
  [poblacion] = poblacionInicial(tamano_poblacion,L,I_alpha,I_beta); %search space
  
%Creating the array containing the values of the objective function
  [funcion_objetivo] = funcionObjetivo (poblacion, tamano_poblacion);
  funcion_objetivo = funcion_objetivo.PT; % converting from struct to double

% Cycle that will run until condition is met:
% Condition 1: That max_iter evaluations are reached
  
 while parar == false
      
     disp(['Iteration number = ' num2str(iter) ',Evaluating Evolutionary Algorithm, Optimal RMSE  = ' num2str(mejorRMSE) ', Remaining ' num2str(max_iter-iter) ' iterations']);
    
     % Generate the mating pool using selection process
     
      %The roulette wheel algorithm μ: parents into a mating pool λ: number of
      %select members from the set of μ Given the cumulative probability  
      disp('Artificial Selection: The roulette wheel algorithm μ');
      [mating_pool,objective_function_pool] = selectionWheel (funcion_objetivo, tamano_poblacion, poblacion);
      
      %Generate λ new individuals using variation operators
      
      %Crossover operator (Real-Valued)
      disp('Cross-over Operator: "Simple Arithmetic Cross-over"');
      [Offspring, R1, factor_prob_cross] = CruceR(mating_pool,V,max_iter,iter);
      
      %Mutation operator
      %One argument operator, and are executed on the population of genes
      %with probability PM € [0;1].
      disp('Mutation Operator: Uncorrelated Mutation with one Step Size');
      [Offspring,Rmut,Pm] = Mutacion( Offspring,iter,max_iter,I_alpha,I_beta);
      
           
      if (R1<factor_prob_cross || Rmut<Pm) %Evaluate individuals for the next generation
      
      % Survivor Selection
      % SELECT individuals for the next generation.
      [poblacion, funcion_objetivo] = Survivor_selection(mating_pool, Offspring, objective_function_pool, tamano_poblacion);
      
      end
      
      %Proceso para seleccionar mejor RMSE
      disp('Selection RMSE_opt and index');
      [RMSE_opt, best] = min(funcion_objetivo); %struct2array
      [~, worst] = max(funcion_objetivo);
   
    
    if mejorRMSE > RMSE_opt
       mejorRMSE = RMSE_opt;
       x1 = poblacion(best, 1:L-1);
       beta_optimal = poblacion(best,end);
       
    elseif mejorRMSE ~= RMSE_opt
        
         % Elitism (Replace Worst)
       poblacion(end,1:L-1) = x1;
       poblacion(end,end) = beta_optimal;
       RMSE_opt = mejorRMSE;
       [best,~] = size(poblacion); % Final position in the population
-
    end %endif

   
    %Stop condition number 1
    if RMSE_opt < 1   % Fix Quality
      
        parar = true;
      
    end %endif
    
    %Stop condition number 2
    if iter == max_iter
      parar = true;
    end %endif
    
    iter=iter+1;

    % Varying parameter: Parameter control - Representation: Reinitialise 
    % population with new coding is hamming distance between the best and 
    % worst strings of the current population is not greater than 1.
    HD = pdist([poblacion(best,:); poblacion(worst,:)],'hamming') % Hamming distance
    if HD < 1 && iter < floor(0.7*max_iter) % Depth in finding final iterations to increase exploitation
       %Reinitialise population arrangement with new coding 
       [poblacion, funcion_objetivo] = poblacion_restarts(poblacion,best,RMSE_opt);
    end
    
    RMSE_opt_Temp(iter) = mejorRMSE;                %Best f(x) — Best fitness function value
    Worst_score(iter) = max(funcion_objetivo);      %Worst f(x) — Best fitness function value; struct2array
    Mean_fitnnes(iter) = mean(funcion_objetivo);    %Mean f(x) — Mean fitness function value; struct2array
    average_distance(iter) = mean(pdist(poblacion));%Average distance between individuals

 end %end while
 
 disp('The best RMSE value is')
 mejorRMSE % Edit 
 
 disp('The optimal coefficients Alpha is')
 ALPHA_optimo = x1(1, 1:end-2)
 
 disp('The optimal threshold beta is')
 beta_optimal 
 
 % Saving variables of interest
cd /home/dmendez/mcode/DATABASE
% Save multichannel QRS complex detection performance
save('Performance_PT1_EA_T24_Main','RMSE_opt','ALPHA_optimo','funcion_objetivo', 'poblacion','beta_optimal','RMSE_opt_Temp','average_distance','Mean_fitnnes','Worst_score');
 
  toc
  
% perform multichannel detections
multichannel_detector_performance_main;




