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

 % Hilbert transform-based [HT] filter-based

    disp(['Training HT detector in ' database]);
    [performance.Train.HT, funcion_objetivo.HT] = multichannel_detector_training_EA(detectionsTemp{2}.HT, database, beta,tamano_poblacion,poblacion);

% Saving variables of interest
cd /home/dmendez/mcode/DATABASE
% Save multichannel QRS complex detection performance
save('Performance_HT_EA_Train','performance','funcion_objetivo','poblacion');


end
