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

    disp(['Training HT detector in ' database]);
    [performance.Train.HT, funcion_objetivo.HT] = multichannel_detector_training_EA(detectionsTemp{2}.HT, database, beta,tamano_poblacion,poblacion);

% Saving variables of interest
cd /home/dmendez/mcode/DATABASE
% Save multichannel QRS complex detection performance
save('Performance_HT_EA1_T27_Train','performance','funcion_objetivo','poblacion');    
end