function [performance, funcion_objetivo] = multichannel_detector_training_EA(detections, database, beta,tamano_poblacion,poblacion)
% This function permits to train the multichannel detector. Weighting
% coefficients alpha and decision threshold beta were estimated in the
% learning period. As recommended by the ANSI/AAMI EC38:1998, the first
% five minutes of each record were used in a learning period to estimate
% coefficients alpha and threshold beta.
% Author: Miguel Altuve, PhD
% Date: March 2018
% Email: miguelaltuve@gmail.com
% Edit: Dilio Méndez
% Last updated: May 20 2021

% Initialization of variables
        data_path = 'INCART';
        fs = 257; % Sampling frequency


% Time specifying the match window size. A detection time is
% considered TP if it lies within a 150 ms matching window of a
% reference annotation time
matchWindow = '0.15';

% The multi-channel QRS complex detector simultaneously monitors N
% different ECG channels for the detection of QRS complexes. Once detection
% is signaled in a given ECG channel, a time window TD is opened during
% which the detections signaled in other ECG channels are considered
% simultaneous and over which the final decision rule is applied. Window TD
% was chosen to be 150 ms long (TD = matchWindow) to tackle with the
% different QRS complex morphologies and different latencies of the cardiac
% electric phenomena, as consequence of the spatial variation of electrode
% placement, that could produce individual decisions shifted in time.
TD = ceil(150/1000*fs);

cd(data_path);
rec_ext='dat'; % using the WFDB binary dataset
records=dir(['*.' rec_ext]);
L=length(records); % Number of records in the database
N = size(detections,1); % Number of ECG channels in the database


%=======Estimating weighting coefficients Alpha and decision Threshold beta=================
% Threshold beta, used to decide whether a detection is true or false, was
% estimated in the learning period. For various threshold values, the
% threshold that leads to the shortest mean absolute error detection was selected

disp('Estimating weighting coefficients Alpha and decision Threshold beta');

M = length(beta); % number of thresholds
performance = zeros(M,9); % matrix of performance


%  Evaluate detection and MAE on every individuals
for j1 = 1 : M
    
    disp(['Evaluating multichannel individual in ' database ', Individual weighting coefficients and threshold beta number = ' num2str(j1) ', Remaining ' num2str(tamano_poblacion-j1) ' individuals']);
    
    TEMP = zeros(L,8); %
    
        
    % Evaluate detection on every record (the first 5 minutes of the record)
    for i = 1 : L
        
        record_id=records(i).name(1:3); % name of record
        record_id_temp = record_id;
        
        % Reading N singlechannel detections of record i
        det = detections(i,:);
        
        
        % Perform optimal fusion from signlechannel detections
        det = performFusionOptTrain(det, TD, poblacion(j1,1:end-3), beta(j1));
        
        
        % In case there are no detections reported by the multichannel detector
        if isempty(det)
            
            % As recommended by the ANSI/AAMI EC38:1998, the first 5
            % minutes of each record were used in a learning period to
            % estimate coefficients alpha. Also, a beat-by-beat comparison
            % was performed using MATLAB wrapper function bxb.
            cd ..
            % Reading the annotation provided in the database (do not use
            % rdann because the number obtained is incorrect)
            report=bxb([database '/' record_id],'atr','atr',['bxbReport' record_id '.txt'],'0','300',matchWindow);
            delete(['bxbReport' record_id '.txt']);
            
            % Measures
            tp =0; % True positive
            fn =sum(sum(report.data(1:5,1:5)))+sum(report.data(1:5,6)); % False negative
            fp =0; % False positive
            
        else
            
            
            det = det(:); % Convert the vector into a column vector
            
            % Write detections to disk
            type = char('N'*(ones(size(det,1),1)));
            subtype = zeros(size(det,1),1);
            chan = zeros(size(det,1),1);
            num = zeros(size(det,1),1);
            wrann(record_id,'test',det,type,subtype,chan,num);
            
            % As recommended by the ANSI/AAMI EC38:1998, the first 5
            % minutes of each record were used in a learning period to
            % estimate coefficients alpha. Also, a beat-by-beat comparison
            % was performed using MATLAB wrapper function bxb.
            cd ..
            report=bxb([database '/' record_id],'atr','test',['bxbReport' record_id '.txt'],'0','300',matchWindow);
            delete(['bxbReport' record_id '.txt']); % Deleting the file
            
            % Measures
            tp =sum(sum(report.data(1:5,1:5))); % True positive
            fn =sum(report.data(1:5,6)); % False negative
            fp =sum(report.data(6:end,1));  % False positive
            
        end
        
        % Performance metrics
        Se = tp/(tp+fn)*100; % Sensitivity
        PP = tp/(tp+fp)*100; % Positive predictivity
        if isnan(PP) % In case tp and fp are 0, PP is undefined.
            PP = 100;
        end
        DER = (fp+fn)/(tp+fn)*100; % Detection error rate
        
        % The shortest Euclidean distance to perfect detection (point (0,1)
        % in the ROC curve)
        SDTP = sqrt( (1-Se/100)^2 + (1-PP/100)^2 );
        
        % Evaluate MAE
        % RMSE = sqrt((1/n)*sum(abs(x(i)-det(i))))
        % Read annotations 
        
        det_temp = det; 
        x = rdann([database '/' record_id_temp],'atr',[],[],[],[]); % Read file With Annotations: reference beat annotationes (atr)
        n1 = length(x); % Number of samples Annotations
        n2 = length(det_temp); % Number of samples fusion vector
        if n1 > n2
            for k1 = (n2+1):n1 
                det_temp(k1,1) = 0; %
            end
           n = n1;
        else
            for k2 = (n1+1):n2
            x(k2,1) = 0;
            end
            n = n2;
        end
        

        Sum_Temp = 0;
        Suma = 0;
        for z1 = 1:n
        Sum_Temp(z1) = abs(x(z1)-det_temp(z1));
        Suma = Suma+Sum_Temp(z1);
        end
        RMSE = sqrt((1/n)*Suma); % MAE for record i and individual weighting coefficients j1
        
        TEMP(i,:) = [tp,fn,fp,Se,PP,DER,SDTP,RMSE];
        
        cd(data_path);
        
    end
    performance(j1,:) = [beta(j1), sum(TEMP)];
    performance(j1,5:end) = performance(j1,5:end)/L; % Performance average
    x=[];
end

% Get MAE
funcion_objetivo = performance(:,9); % MAE  Values for individual weighting coefficients j1

cd ..

end
