function [funcion_objetivo] = funcionObjetivo(poblacion, tamano_poblacion)

%The performance of the detector is evaluated for the Beta and Alpha values in the EA.
%The Mean Absolute Error (MAE) corresponds to the objective function,
%since it is measure of errors between paired observations that express the same event.

database = 'INCART';

% Loading singlechannel detections
cd /home/dmendez/mcode/DATABASE
load('DetectionsSinglechannel')

detectionsTemp = detections;
clear detections; % the name det

 % GQRS PhysioNet's detectors 

    disp(['Training GQRS detector in ' database]);
    [performance.Train.GQRS, funcion_objetivo.GQRS] = multichannel_detector_training_EA(detectionsTemp{2}.GQRS, database, beta,tamano_poblacion,poblacion);

% Saving variables of interest
cd /home/dmendez/mcode/DATABASE
% Save multichannel QRS complex detection performance
save('Performance_GQRS_EA_Train','performance','funcion_objetivo','poblacion');


end
