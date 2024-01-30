# OptimizationofMultichannelQRSdetector
Code of the paper Optimizing Multichannel QRS Complex Detection Using Evolutionary Algorithms.

The proposed method for QRS complex detection is based on the work of Ledezma and Altuve [1]. In the general scheme of the proposed methodology, three main stages are identified: Evolutionary process, decentralized data fusion and performance evaluation.

![Resumen-visual-EA](https://github.com/JoseMendezA/OptimizationofMultichannelQRSdetector/blob/main/ProjectImages/optimizationscheme.png)

This approach was validated using three commonly used single-channel detectors in the literature: Pan and Tompkins (PT) [2], GQRS from PhysioNet [4,5], and Benítez (HT, for Hilbert Transform-based detector) [3].

To conduct this study, the St Petersburg INCART 12-lead Arrhythmia database available on Physionet (https://physionet.org/content/incartdb/1.0.0/) was used.  

The following MATLAB functions correspond to the single-channel QRS complex detectors:

1. pan_tompkin.m: Pan and Tompkins filter-based detection method [2]. Coded by Hooman Sedghamiz (2014), Linkoping university.
2. detectHT.m: Benítez et al. Hilbert transform-based detection method [3].

## Instructions for running a simple simulation

In the main script according to the selected detector (PT, HT, GQRS):
   - We set the hyperparameters through the experiment design: 
      - Population size ($\mu$); chromosome length (L); 
      - the number of independent variables in an optimized task (V) (in this case, each chromosome is represented by 27 independent variables of a gene) 
      - and prespecified params (barrier constraints for ${\alpha}_j$ y $\beta$).
  - Setting of algorithm termination conditions (maximum number of generations, ${\delta}_(max)$).
  
1. We first computed the detections of QRS complexes on each ECG channel and the performance of the QRS complex detectors using three different QRS complex detectors in the INCART database. The single-channel detectors are: based on Pan and Tompkins filters (PT) [2], Benítez et al. Based on Hilbert transform (HT) [3] and GQRS PhysioNet detector [4,5]. This is done in the singlechannel_detection_performance_main.m file.

With the purpose of generalizing the approach and optimizing the selection of the coefficients ${\alpha}_j$ and $\beta$, an evolutionary algorithm was used to determine them. Through the evolutionary process, the model parameters are trained, which are used in the decentralized data fusion as follows:
   
2.  In the second stage, the evolutionary process begins to find the optimal values of ${\alpha}_j$ y $\beta$. This is done automatically (self-adaptively) in the main script file: We performed the fusion of the single-channel detections and computed the performances using the funcionObjetivo.m and multichannel_detector_training_EA files. In this files, the weighting coefficients and the decision threshold are estimated (in the training period); and we quantify global detection by comparing the fusion function with the decision threshold $\beta$. The performance of the detectors was evaluated using the MATLAB wrapper function bxb. 

4. The performance of the model is evaluated based on the mean absolute error (MAE) between the global detection recorded by the model and the database annotations. This is done in the multichannel_detector_performance_main.m file.

## Abstract
Accurate QRS complex detection is crucial in electrocardiogram (ECG) analysis for diagnosing cardiovascular diseases. While single-channel QRS detectors have been commonly used, multichannel approaches hold the potential to enhance accuracy. In this study, we present a method to optimize multichannel QRS complex detection using Evolutionary Algorithms (EAs). Building upon a previous multichannel fusion approach, we aimed to improve its performance through EA-based parameter optimization. We assessed three popular QRS detectors-Pan and Tompkins, GQRS, and a Hilbert Transform-based within this multichannel framework using the INCART ECG database. Our findings showed that the PT detector outperformed others when integrated into the multichannel setup. It achieved a remarkable sensitivity of 99.96\%, a positive predictive value of 99.95\%, and a low detection error rate of 0.0976\%. The EA's ability to discover high-quality solutions during each run contributed to a substantial reduction in false negatives and positives. We conducted a sensitivity analysis to explore the influence of various EA parameters. Notably, 20 generations emerged as the optimal choice, striking an effective balance between exploration and exploitation. Our auto-adaptive parameter control strategy successfully managed this balance throughout the evolutionary process. One notable contribution of our approach is its capacity to generalize detector configurations, eliminating the need for extensive training. This significantly reduces computation time, making it suitable for real-time applications in healthcare. Moreover, our approach can be easily adapted to different QRS detectors with minimal adjustments, enhancing its versatility. Comparing our multichannel approach with single-channel counterparts and existing multichannel methods highlighted its superiority. It consistently achieved a remarkable balance between sensitivity and precision. Additionally, our method can serve as a foundation for future work exploring hybrid architectures combining multidetector and multichannel approaches to further advance QRS detection accuracy in various medical applications. 

## References

[1] Carlos A. Ledezma, Miguel Altuve (2019) Optimal data fusion for the improvement of QRS complex detection in multi-channel ECG recordings [Source Code]. https://doi.org/10.24433/CO.1171327.v1

[2] Pan, J., & Tompkins, W. J. (1985). A real-time QRS detection algorithm. IEEE Trans. Biomed. Eng, 32(3), 230-236.

[3] Benitez, D. S., Gaydecki, P. A., Zaidi, A., & Fitzpatrick, A. P. (2000, September). A new QRS detection algorithm based on the Hilbert transform. In Computers in Cardiology 2000. Vol. 27 (Cat. 00CH37163) (pp. 379-382). IEEE.

[4] Silva, I., & Moody, G. B. (2014). An open-source toolbox for analysing and processing physionet databases in matlab and octave. Journal of open research software, 2(1).

[5] Goldberger, A. L., Amaral, L. A., Glass, L., Hausdorff, J. M., Ivanov, P. C., Mark, R. G., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: components of a new research resource for complex physiologic signals. Circulation, 101(23), e215-e220.
