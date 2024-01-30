# OptimizationofMultichannelQRSdetector
Código del artículo titulado Optimizing Multichannel QRS Complex Detection Using Evolutionary Algorithms.

The proposed method for QRS complex detection is based on the work of Ledezma and Altuve [1]. In the general scheme of the proposed methodology, three main stages are identified: Evolutionary process, decentralized data fusion and performance evaluation.

![Resumen-visual-EA](https://github.com/JoseMendezA/OptimizationofMultichannelQRSdetector/blob/main/ProjectImages/optimizationscheme.png)

This approach was validated using three commonly used single-channel detectors in the literature: Pan and Tompkins (PT) [2], GQRS from PhysioNet [4,5], and Benítez (HT, for Hilbert Transform-based detector) [3].

To conduct this study, the St Petersburg INCART 12-lead Arrhythmia database available on Physionet (\url{https://physionet.org/content/incartdb/1.0.0/}) was used.  

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
Accurate QRS complex detection is crucial in electrocardiogram (ECG) analysis for diagnosing cardiovascular diseases. While single-channel QRS detectors have been commonly used, multichannel approaches hold the potential to enhance accuracy. In this study, we present a method to optimize multichannel QRS complex detection using Evolutionary Algorithms (EAs). Building upon a previous multichannel fusion approach, we aimed to improve its performance through EA-based parameter optimization. We assessed three popular QRS detectors-Pan and Tompkins, GQRS, and a Hilbert Transform-based within this multichannel framework using the INCART ECG database. Our findings showed that the PT detector outperformed others when integrated into the multichannel setup. It achieved a remarkable sensitivity of 99.96\%, a positive predictive value of 99.95\%, and a low detection error rate of 0.0976\%. The EA's ability to discover high-quality solutions during each run contributed to a substantial reduction in false negatives and positives. We conducted a sensitivity analysis to explore the influence of various EA parameters. Notably, 20 generations emerged as the optimal choice, striking an effective balance between exploration and exploitation. Our auto-adaptive parameter control strategy successfully managed this balance throughout the evolutionary process. One notable contribution of our approach is its capacity to generalize detector configurations, eliminating the need for extensive training. This significantly reduces computation time, making it suitable for real-time applications in healthcare. Moreover, our approach can be easily adapted to different QRS detectors with minimal adjustments, enhancing its versatility. Comparing our multichannel approach with single-channel counterparts and existing multichannel methods highlighted its superiority. It consistently achieved a remarkable balance between sensitivity and precision. Additionally, our method can serve as a foundation for future work exploring hybrid architectures combining multidetector and multichannel approaches to further advance QRS detection accuracy in various medical applications. 

## References

[1] Carlos A. Ledezma, Miguel Altuve (2019) Optimal data fusion for the improvement of QRS complex detection in multi-channel ECG recordings [Source Code]. https://doi.org/10.24433/CO.1171327.v1

[2] Pan, J., & Tompkins, W. J. (1985). A real-time QRS detection algorithm. IEEE Trans. Biomed. Eng, 32(3), 230-236.

[3] Benitez, D. S., Gaydecki, P. A., Zaidi, A., & Fitzpatrick, A. P. (2000, September). A new QRS detection algorithm based on the Hilbert transform. In Computers in Cardiology 2000. Vol. 27 (Cat. 00CH37163) (pp. 379-382). IEEE.

[4] Silva, I., & Moody, G. B. (2014). An open-source toolbox for analysing and processing physionet databases in matlab and octave. Journal of open research software, 2(1).

[5] Goldberger, A. L., Amaral, L. A., Glass, L., Hausdorff, J. M., Ivanov, P. C., Mark, R. G., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: components of a new research resource for complex physiologic signals. Circulation, 101(23), e215-e220.
