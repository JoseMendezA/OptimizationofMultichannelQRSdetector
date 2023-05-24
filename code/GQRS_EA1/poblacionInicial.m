function [poblacion]= poblacionInicial(tamano_poblacion,L,I_alpha,I_beta)
% Create Population
% Real number coding: the value represented by particular gene randomly chosen from the range I[Imin;Imax]
% determined  individually for each variable.

% initialize the random number generator 
rng(1,'twister'); % For reproducibility
% 
% % Get generator settings.
% % Save the generator settings in a structure s.
s = rng; %seed generator: Save current settings of the generator.
% 
% % Call rand.
poblacion = rand(tamano_poblacion,L); %array of random elements between zero and one  

% Restore previous generator settings.
rng(s); 

% Range Alpha I_alpha I_alpha=[Imin Imax)
% Population is scaled in the search range I_alpha=[Imin Imax]
% Population For Alpha Coefficients from L1 to L24 in L = Chromosome length
% Gene randomly chosen from the range I[Imin = 0; Imax = 1]
poblacion_alpha = poblacion(:,1:end-2)*(I_alpha(1,2)-I_alpha(1,1))+I_alpha(1,1); % from L1 to L26 in L = Chromosome length


% Population is scaled in the search range I_beta=[Imin Imax]
poblacion_sd_beta = poblacion(:,end-1)*I_beta(1,2); %Standar deviation for L26 in L = Chromosome length

poblacion_beta = poblacion(:,end)*(I_beta(1,2)-I_beta(1,1))+I_beta(1,1); % for L27 in L = Chromosome length

poblacion = [poblacion_alpha poblacion_sd_beta poblacion_beta];    
end