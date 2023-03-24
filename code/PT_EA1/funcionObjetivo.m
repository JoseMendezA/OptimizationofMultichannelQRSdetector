function [funcion_objetivo] = funcionObjetivo(poblacion, tamano_poblacion) 

% Se evalua el desempeño del detector para los valores de Beta en el algoritmo evolutivo.
% La distancia euclidiana perfecta corresponde a la función objetivo, dado
% que dicha función me relaciona para una valor dado de Beta, el desempeño
% en terminos de la Se y +P.

database = 'INCART'; % 

% Loading singlechannel detections
cd /home/dmendez/mcode/DATABASE
load('DetectionsSinglechannel')
            
detectionsTemp = detections;
clear detections; % the name det

 % Pan and Tompkins filter-based
    % Training
    % Detection threshold vector to find the optimal threshold
        beta = poblacion(:,end); % uncomment this line to find the optimal beta within a search space
    %%%--- comment this part if the previous line was uncommented ----%%
%     'MIT' These are the optimal values reported in the paper
%         beta = -0.125;
%     'INCART'
%         beta = 0.2;

    disp(['Training PT detector in ' database]);
    [performance.Train.PT, funcion_objetivo.PT] = multichannel_detector_training_EA(detectionsTemp{2}.PT, database, beta,tamano_poblacion,poblacion);

% Saving variables of interest
cd /home/dmendez/mcode/DATABASE
% Save multichannel QRS complex detection performance
save('Performance_PT1_EA_T24_Train','performance','funcion_objetivo','poblacion');    


end