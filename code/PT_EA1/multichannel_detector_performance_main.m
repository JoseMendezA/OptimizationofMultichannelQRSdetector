% This script permits obtaining multichannel QRS complex detection
% performance by optimally combining singlechannel QRS complex detections.
% Singlechannel QRS complex detections come from six different detectors:
% Pan and Tompkins filter-based (PT), Benitez et al. Hilbert
% transform-based (HT), Ramakrishnan et al. dynamic plosion index-based
% (DPI), and GQRS, WQRS and SQRS PhysioNet's detectors.
% The performance is estimated on two different databases: MIT and INCART.
% As recommended by the ANSI/AAMI EC38:1998, the first five minutes of each
% record were used in a learning period and the remainder of the record was
% used to evaluate the detector performance.
% Author: Miguel Altuve, PhD
% Date: March 2018
% Email: miguelaltuve@gmail.com
% Last updated: Oct 2020

database = 'INCART'; % name of the database

% Loading singlechannel detections
cd /home/dmendez/mcode/DATABASE
load('DetectionsSinglechannel')

detectionsTemp = detections;
clear detections; % the name detections will be used again

% load('ALPHA_optimo')
load('Performance_PT1_EA_T24_Main.mat', 'ALPHA_optimo'); % Calculated at Training

% load('beta_optimo')
load('Performance_PT1_EA_T24_Main.mat', 'beta_optimal'); % Calculated at Training 

cd /home/dmendez/mcode/DATABASE

    beta_opt = beta_optimal;
    
%     %%%---------------------------------------------------------------%%
    disp(['Test PT detector in ' database]);
%     [performance{i}.Train.PT, coefficients{i}.PT, beta_opt{i}.PT] = multichannel_detector_training(detectionsTemp{i}.PT, database{i}, beta);
%     % Test
    [performance.Test.PT, detections.PT] = multichannel_detector_test(detectionsTemp{2}.PT, database, beta_opt, ALPHA_optimo);
    
 
% % Saving variables of interest
cd /home/dmendez/mcode/DATABASE
% % Save multichannel QRS complex detections (QRS complex localization)
save('Detections_PT1_EA_T24_Test','detections');
% % Save multichannel QRS complex detection performance
save('Performance_PT1_EA_T24_Test','performance','ALPHA_optimo','beta_optimal');