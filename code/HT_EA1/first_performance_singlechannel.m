% This script allows to obtain the best QRS complex detection performances in the INCART database, 
% for the detection stage of a single channel  independently.
% Singlechannel QRS complex detections come from six different detectors:
% Pan and Tompkins filter-based (PT), Benitez et al. Hilbert
% transform-based (HT), Ramakrishnan et al. dynamic plosion index-based
% (DPI), and GQRS, WQRS and SQRS PhysioNet's detectors.
% The detector with the best average performance in the twelve leads of the ECG is selected. 
% Author: Dilio Méndez
% Date: March 2020
% Email: dilio.mendez.2020@upb.edu.com.co
% Last updated: 01 April 2020

cd /home/dmendez/mcode/DATABASE

database = {'MIT','INCART'}; % name of the databases

% Loading singlechannel Performances
load('PerformanceSinglechannel')

for i = 1 : length(database)

    % Mean Singlechannel performance of PT detector
    [SD] = evaluate_performance_singlechannel_detector('PT', database{i}, performance{i}.PT);
    sd{i}.PT= SD; % field PT on struct Main performance detector

    % Singlechannel performance of HT detector
    [SD] = evaluate_performance_singlechannel_detector('HT', database{i}, performance{i}.HT);
    sd{i}.HT= SD; % field HT on struct Main performance detector

    % Mean Singlechannel performance of PT detector
    [SD] = evaluate_performance_singlechannel_detector('DPI', database{i}, performance{i}.DPI);
    sd{i}.DPI= SD; % field DPI on struct Main performance detector

    % Mean Singlechannel performance of PT detector
    %Test single lead GQRS algorithm
    [SD] = evaluate_performance_singlechannel_detector('GQRS', database{i}, performance{i}.GQRS);
    sd{i}.GQRS = SD; % field GQRS on struct Main performance detector

    % Mean Singlechannel performance of PT detector
    [SD] = evaluate_performance_singlechannel_detector('WQRS', database{i}, performance{i}.WQRS);
    sd{i}.WQRS= SD; % field WQRS on struct Main performance detector

    % Mean Singlechannel performance of PT detector
    [SD] = evaluate_performance_singlechannel_detector('SQRS', database{i}, performance{i}.SQRS);
    sd{i}.SQRS= SD; % field SQRS on struct Main performance detector

end

% Saving variables of interest
cd /home/dmendez/mcode/DATABASE
% Save singlechannel QRS complex detections (QRS complex localization)
save('mean_Detector_Singlechannel','sd');


%Function Mean singlechannel_detection_performance

function [sd] = evaluate_performance_singlechannel_detector(DetectorName, database, performance)

% from database {i}
 for i = 1 : length(database)

     switch database
   
    case 'MIT'
        N = 2; % Number of ECG channels in the database
        
        
    case 'INCART'
        N = 12; % Number of ECG channels in the database 
       
     end
     
    sd = cell(1, N); % Cell of main performance
     
     for j = 1 : N
         
         switch DetectorName 
             
            case 'PT'
                   sd{j} = mean(str2double(performance{j}(:,8))); % str2double(performance{2}.PT{12}(:,8));
                                                         
            case 'HT'
                   sd{j} = mean(str2double(performance{j}(:,8))); % Mean of SDTP channel j case HT, first convert from string to double using str2double   
                   
            case 'DPI'
                   sd{j} = mean(str2double(performance{j}(:,8))); % Mean of SDTP channel j case DPI, first convert from string to double using str2double
                   
            case 'GQRS'
                   sd{j} = mean(str2double(performance{j}(:,8))); % Mean of SDTP channel j case GQRS, first convert from string to double using str2double 
                   
            case 'WQRS'
                   sd{j} = mean(str2double(performance{j}(:,8))); % Mean of SDTP channel j case WQRS, first convert from string to double using str2double 
                   
            case 'SQRS'
                   sd{j} = mean(str2double(performance{j}(:,8))); % Mean of SDTP channel j case SQRS, first convert from string to double using str2double      
                   
         end
         
     end
     
     
     
 end

 
end




