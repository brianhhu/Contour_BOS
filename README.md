# Contour_BOS
Project code associated with Hu_etal '17 paper on contour integration and border ownership assignment

### Introduction

The program is written in MATLAB (Mathworks). The code is known to run on R2014a, but should also be compatible with other versions. The main program function is **demo.m**. Running this program will simulate the network model on different input stimuli, corresponding to the contour integration experiments (Chen et al., 2014) and the border ownership experiments (Qiu et al., 2007). To reproduce a subset of the figures shown in the paper, run **plot_figs.m**. For more details about the experiments and/or the model, please see the following references:

    @Article{Hu_etal17,
      Title                    = {A recurrent neural model of proto-object based contour integration and figure-ground segregation},
      Author                   = {Hu, Brian and Niebur, Ernst},
      Journal                  = {Journal of Computational Neuroscience},
      Year                     = {2017},
      Pages                    = {},
      Volume                   = {},
      Doi                      = {},
    }

    @Article{Chen_etal14,
        Title     = {Incremental integration of global contours through interplay between visual cortical areas},
        Author    = {Chen, Minggui and Yan, Yin and Gong, Xiajing and Gilbert, Charles D and Liang, Hualou and Li, Wu},
        Journal   = {Neuron},
        Year      = {2014},
        Volume    = {82},
        Number    = {3},
        Pages     = {682--694},
        Publisher = {Elsevier},
    }
    
    @Article{Qiu_etal07,
        Title                    = {Figure-ground mechanisms provide structure for selective attention},
        Author                   = {F. T. Qiu and T. Sugihara and R. von der Heydt},
        Journal                  = {Nat. Neurosci.},
        Year                     = {2007},
        Month                    = {October},
        Number                   = {11},
        Pages                    = {1492-9},
        Volume                   = {10}
    }

### Miscellaneous

The final simulation results used in the paper can be found in the **Results** directory. Our paper detailing the recurrent neural model can be found in the **resources** directory.

If you have any questions, please feel free to contact me at bhu6 (AT) jhmi (DOT) edu.
