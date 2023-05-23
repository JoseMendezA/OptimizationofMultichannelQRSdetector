# OptimizationofMultichannelQRSdetector
Código del artículo titulado Optimization of Multi-channel Detection of the QRS Complex in ECG Recordings using Evolutionary Algorithms.

El método de detección de complejos QRS propuesto está basado en el trabajo de Ledezma y Altuve [1]. En el esquema general de la metodología propuesta se identifican tres etapas principales: Proceso evolutivo, fusión de datos descentralizada y la evaluación y desempeño. 

![Resumen-visual-EA](https://github.com/JoseMendezA/OptimizationofMultichannelQRSdetector/blob/main/ProjectImages/Esquema%20_Optimizacion%20_Multicanal5.png)

En el enfoque se utilizaron 3 detectores de complejos QRS de un solo canal: Pan y Tompkins [2], Benítez et al. [3] y el detector GQRS de PhysioNet [4,5]. La base de datos ECG multicanal utilizada fue la INCART.  

Las siguientes funciones de MATLAB corresponden a los detectores complejos QRS de un solo canal:

1. pan_tompkin.m: método de detección basado en filtros Pan y Tompkins [2]. Codificado por Hooman Sedghamiz (2014), Universidad de Linkoping.
2. detectHT.m: Benítez et al. Método de detección basado en la transformada de Hilbert [3].

Inicialmente se fijan los hiperparámetros del modelo mediante un diseño experimental multifactorial ${3}^3$ (sintonización de hiperparámetros). Los niveles se seleccionaron mediante una amplia exploración en un espacio finito con distintos valores por factor, acotando las combinaciones mediante el método Grid Search.

Posteriormente, con el proposito de generalizar el enfoque y optimizar la selección de los coeficientes ${\alpha}_j$ y $\beta$, se utilizó un algoritmo evolutivo para determinarlos. A través del proceso evolutivo se efectúa el entrenamiento de los parámetros del modelo, los cuales se utilizan en la fusión de datos descentralizada de la siguiente manera:

1. Calculamos las detecciones de complejos QRS en cada canal del ECG y el rendimiento de los detectores de complejos QRS. Esto se hace en el archivo singlechannel_detection_performance_main.m.

2. Efectuamos la fusión de datos provenientes de cada canal con los valores para los coeficientes ${\alpha}_j$ y $\beta$ aprendidos en el proceso evolutivo. Cuantificamos la detección global al comparar la función de fusión con el umbral de decisión $\beta$. 

3. Se evalua el desempeño del modelo a partir del error absoluto medio (MAE) entre la detección global registrada por el modelo y las anotaciones de la base de datos. 

## Instrucciones para ejecutar una simulación simple


## Abstract
Detecting the QRS complex is the most fundamental task in automatically processing and analyzing electrocardiogram (ECG) recordings. However, the combination of the redundant information available from different sources has not been fully exploited to improve the detection of this typical ECG waveform. Therefore, in this work, we are interested in improving the detection performance of QRS complexes on multi-channel ECG recordings using evolutionary algorithms (EA). Specifically, we optimally combined single-channel QRS complex detections into a single detection signal by minimizing the detection error rate as a cost function. QRS detection performances of three commonly used detectors on the twelve ECG channel INCART database show increases of up to 0.44\% in sensitivity and up to 0.25\% in positive predictivity and a reduction of up to 0.85% in the detection error rate compared with their single-channel detector counterparts. 

## References

[1] Carlos A. Ledezma, Miguel Altuve (2019) Optimal data fusion for the improvement of QRS complex detection in multi-channel ECG recordings [Source Code]. https://doi.org/10.24433/CO.1171327.v1

[2] Pan, J., & Tompkins, W. J. (1985). A real-time QRS detection algorithm. IEEE Trans. Biomed. Eng, 32(3), 230-236.

[3] Benitez, D. S., Gaydecki, P. A., Zaidi, A., & Fitzpatrick, A. P. (2000, September). A new QRS detection algorithm based on the Hilbert transform. In Computers in Cardiology 2000. Vol. 27 (Cat. 00CH37163) (pp. 379-382). IEEE.

[4] Silva, I., & Moody, G. B. (2014). An open-source toolbox for analysing and processing physionet databases in matlab and octave. Journal of open research software, 2(1).

[5] Goldberger, A. L., Amaral, L. A., Glass, L., Hausdorff, J. M., Ivanov, P. C., Mark, R. G., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: components of a new research resource for complex physiologic signals. Circulation, 101(23), e215-e220.