# OptimizationofMultichannelQRSdetector
Article code Optimization of Multi-channel Detection of the QRS Complex in ECG Recordings using Evolutionary Algorithms.

El método de detección de complejos QRS propuesto está basado en el trabajo de Ledezma y Altuve [1]. En el esquema general de la metodología se identifican tres etapas principales: Proceso evolutivo, fusión de datos descentralizada y evaluación y desempeño.

![Resumen-visual-EA](https://github.com/JoseMendezA/OptimizationofMultichannelQRSdetector/blob/main/ProjectImages/Esquema%20_Optimizacion%20_Multicanal5.png)

## Abstract
Detecting the QRS complex is the most fundamental task in automatically processing and analyzing electrocardiogram (ECG) recordings. However, the combination of the redundant information available from different sources has not been fully exploited to improve the detection of this typical ECG waveform. Therefore, in this work, we are interested in improving the detection performance of QRS complexes on multi-channel ECG recordings using evolutionary algorithms (EA). Specifically, we optimally combined single-channel QRS complex detections into a single detection signal by minimizing the detection error rate as a cost function. QRS detection performances of three commonly used detectors on the twelve ECG channel INCART database show increases of up to 0.44\% in sensitivity and up to 0.25\% in positive predictivity and a reduction of up to 0.85% in the detection error rate compared with their single-channel detector counterparts. 

## References

[1] Carlos A. Ledezma, Miguel Altuve (2019) Optimal data fusion for the improvement of QRS complex detection in multi-channel ECG recordings [Source Code]. https://doi.org/10.24433/CO.1171327.v1

[2] Pan, J., & Tompkins, W. J. (1985). A real-time QRS detection algorithm. IEEE Trans. Biomed. Eng, 32(3), 230-236.

[3] Benitez, D. S., Gaydecki, P. A., Zaidi, A., & Fitzpatrick, A. P. (2000, September). A new QRS detection algorithm based on the Hilbert transform. In Computers in Cardiology 2000. Vol. 27 (Cat. 00CH37163) (pp. 379-382). IEEE.

[4] Silva, I., & Moody, G. B. (2014). An open-source toolbox for analysing and processing physionet databases in matlab and octave. Journal of open research software, 2(1).

[5] Goldberger, A. L., Amaral, L. A., Glass, L., Hausdorff, J. M., Ivanov, P. C., Mark, R. G., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: components of a new research resource for complex physiologic signals. Circulation, 101(23), e215-e220.