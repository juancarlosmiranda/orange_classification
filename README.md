# Clasificación automática de naranjas por tamaño y por defectos utilizando técnicas de visión por computadora
Tesis presentada a la [Facultad Politécnica, Universidad Nacional de Asunción](https://www.pol.una.py/), como requisito para la obtención del Grado de Máster en Ciencias de la Computación.
Beca [CONACYT BECA08-25](https://www.conacyt.gov.py/view-inventario-de-tesis?keys=beca08-25) (https://www.conacyt.gov.py/view-inventario-de-tesis?keys=beca08-25). Apoyo financiero de [CONACYT-Paraguay, bajo el programa 14-POS-008](https://datos.conacyt.gov.py/proyectos/nid/209)
* [https://dx.doi.org/10.13140/RG.2.2.15456.35845](https://dx.doi.org/10.13140/RG.2.2.15456.35845)
* [https://repositorio.conacyt.gov.py/handle/20.500.14066/3172](https://repositorio.conacyt.gov.py/handle/20.500.14066/3172)


![SOFTWARE_PRESENTATION](https://github.com/juancarlosmiranda/orange_classification/blob/main/docs/img/orange_classification_diagrams_1.0.png?raw=true)

 
## Resumen
En este trabajo, se propone una metodología automática y reproducible utilizando técnicas de visión por computadora para clasificación de naranjas por tamaño y por defectos. Los pasos propuestos para clasificación por tamaño fueron: adquisición de imágenes, calibración, procesamiento y segmentación de imágenes, extracción de características y clasificación. Se aplicaron 2 técnicas de procesamiento y segmentación de imágenes para separar la fruta. Para clasificación se evaluaron 2 modos: clasificación según umbral, clasificación con aplicación de aprendizaje automático. El método de segmentación 2, basado en umbrales en el espacio CIELAB, demostró ser el mejor y se vió menos afectado por los cambios de iluminación en una comparativa visual. La mejor combinación de procesos ensamblados para clasificación fue la que incluyó: el método de segmentación 2, medición del eje menor a partir de 4 imágenes y clasificación con el algoritmo SVM. 
Los pasos propuestos para detección de defectos fueron: marcación y creación de banco de imágenes, generación de datos para aprendizaje, evaluación de frutas con el algoritmo KNN. La segmentación de defectos consistió en la implementación de 3 variantes combinadas con operaciones de morfología binaria y suavizado. Las regiones fueron sometidas a un proceso de verificación automática contra lo marcado por un experto. La variante 2 basada en el filtro Prewitt demostró una exactitud de 96\%. Para clasificación de defectos se utilizaron características geométricas y de color en conjunto con el algoritmo KNN.
**Palabras claves:** Visión por computadora, Procesamiento de imágenes, Segmentación, Extracción de características, Clasificación, Aprendizaje automático.

# Automatic grading of oranges by size and by defects using computer vision techniques
## Abstract
In this work, an automatic and reproducible methodology is proposed using computer vision techniques for sorting oranges by size and defects. The proposed steps for size classification were: image acquisition, calibration, image processing and segmentation, feature extraction and classification. Two image processing and segmentation techniques were applied to separate the fruit. For classification, 2 modes were evaluated: classification according to threshold, classification with automatic learning application. Segmentation method 2, based on thresholds in the CIELAB space, proved to be the best and was less affected by lighting changes in a visual comparison. The best combination of processes assembled for classification was the one that included: segmentation method 2, measurement of the minor axis from 4 images and classification with the SVM algorithm. 
The proposed steps for defect detection were: marking and creation of an image bank, generation of data for learning, fruit evaluation with the KNN algorithm. The defect segmentation consisted of the implementation of 3 variants combined with binary morphology and smoothing operations. The regions were subjected to an automatic verification process against the marks of an expert. Variant 2 based on the Prewitt filter showed an accuracy of 96 percent. For defect classification, geometric and color characteristics were used in conjunction with the KNN algorithm.
**Keywords:** Computer vision, Image processing, Segmentation, Classification, Machine learning.

Schollarship [CONACYT BECA08-25](https://www.conacyt.gov.py/view-inventario-de-tesis?keys=beca08-25) (https://www.conacyt.gov.py/view-inventario-de-tesis?keys=beca08-25). Financial support from [CONACYT-Paraguay, under program # 14-POS-008](https://datos.conacyt.gov.py/proyectos/nid/209)
* [https://dx.doi.org/10.13140/RG.2.2.15456.35845](https://dx.doi.org/10.13140/RG.2.2.15456.35845)
* [https://repositorio.conacyt.gov.py/handle/20.500.14066/3172](https://repositorio.conacyt.gov.py/handle/20.500.14066/3172)


Python-based GUI tool to extract frames from video files produced with Azure Kinect cameras. Visit the project site
at [https://pypi.org/project/ak-frame-extractor/](https://pypi.org/project/ak-frame-extractor/)



## Contents

1. Pre-requisites.
2. Functionalities.
3. Install and run.
4. Files and folder description.
5. Development tools, environment, build executables.

## 1. Pre-requisites

* MATLAB R2021a.
* Computer Vision System Toolbox
* Statistics and Machine Learning Toolbox (TODO)

* [SDK Azure Kinect](https://docs.microsoft.com/es-es/azure/kinect-dk/set-up-azure-kinect-dk) installed.
* [pyk4a library](https://pypi.org/project/pyk4a/) installed. If the operating system is Windows, follow
  this [steps](https://github.com/etiennedub/pyk4a/). You can find test basic examples with
  pyk4a [here](https://github.com/etiennedub/pyk4a/tree/master/example).
* In Ubuntu 20.04, we provide a script to install the camera drivers following the instructions
  in [azure_kinect_notes](https://github.com/GRAP-UdL-AT/ak_acquisition_system/tree/main/docs/azure_kinect_notes/).
* Videos recorded with the Azure Kinect camera, optional video samples are available at [AK_FRAEX - Azure Kinect Frame Extractor demo videos](https://doi.org/10.5281/zenodo.6968103)


## 2. Functionalities

The functionalities of the software are briefly described. Supplementary material can be
found in [USER's Manual](https://github.com/GRAP-UdL-AT/ak_frame_extractor/blob/main/docs/USER_MANUAL_ak_frame_extractor_v1.md).

* **[Dataset creation]**  This option creates a hierarchy of metadata. This hierarchy contains sub-folders that will be
  used to store the extracted data.
* **[Data Extraction]** The user can configure the parameters for extracting data frames from videos, such as: output
  folder, number of frames to extract. The extraction can be done from one video or by processing a whole folder in
  batch mode.
* **[Data Migration]**  In this tab, we offer a tool for data migration in object labelling tasks. It is used to convert
  files from .CSV format (generated with [Pychet Labeller](https://github.com/acfr/pychetlabeller))
  to [PASCALVOC](https://roboflow.com/formats/pascal-voc-xml) format.

* Data extracted and 3D cloud points can be retrieved from *"your dataset metadata folder"**.

## 3. Install and run

### 3.1 PIP quick install package

Create your Python virtual environment.

```
python3 -m venv ./ak_frame_extractor_venv
source ./ak_frame_extractor_venv/bin/activate
pip install --upgrade pip

pip install python -m ak-frame-extractor
python -m ak_frame_extractor
```

### 3.2 Install and run virtual environments using scripts provided

* [Linux]
  Enter to the folder **"ak_frame_extractor/"**

Create virtual environment(only first time)

```
./creating_env_ak_frame_extractor.sh
```

Run script.

```
./ak_frame_extractor_start.sh
```

* [Windows]
  Enter to the folder "ak_frame_extractor/"

Create virtual environment(only first time)

```
TODO_HERE
```

Run script from CMD.

```
./ak_frame_extractor_start.bat
```

## 4.3 Files and folder description

Folder description:

| Folders                    | Description            |
|---------------------------|-------------------------|
| [docs/](https://github.com/GRAP-UdL-AT/ak_frame_extractor/tree/main/docs) | Documentation |
| [src/](https://github.com/GRAP-UdL-AT/ak_frame_extractor/tree/main/src) | Source code |
| [win_exe_conf/](https://github.com/GRAP-UdL-AT/ak_frame_extractor/tree/main/win_exe_conf) | Specifications for building .exe files with [Pyinstaller](https://pyinstaller.org)..|
| [tools/](https://github.com/GRAP-UdL-AT/ak_frame_extractor/tree/main/tools) | Examples of code to use data migrated. We offer scripts in MATLAB, Python, R. |
| [data/](https://github.com/GRAP-UdL-AT/ak_frame_extractor/tree/main/data) | Examples of output produced by AK_FRAEX, data extracted from recorded video. |
| . | . |

Python environment files:

| Files                    | Description              | OS |
|---------------------------|-------------------------|---|
| activate_env.bat | Activate environments in Windows | WIN |
| clean_files.bat | Clean files under CMD. | WIN |
| creating_env_ak_frame_extractor.sh | Automatically creates Python environments | Linux |
| ak_sm_recorder_main.bat | Executing main script | WIN |
| ak_frame_extractor_start.sh | Executing main script | Linux |
| /ak_frame_extractor_main.py | Python main function | Supported by Python |

Pyinstaller files:
| Files                    | Description              | OS |
|---------------------------|-------------------------|---|
| build_win.bat | Build .EXE for distribution | WIN |
| /src/ak_frame_extractor/__main__.py | Main function used in package compilation | Supported by Python |
| /ak_frame_extractor_main.py | Python main function | Supported by Python |


Pypi.org PIP packages files:
| Files                    | Description              | OS |
|---------------------------|-------------------------|---|
| build_pip.bat | Build PIP package to distribution | WIN |
| /src/ak_frame_extractor/__main__.py | Main function used in package compilation | Supported by Python |
| setup.cfg | Package configuration PIP| Supported by Python |
| pyproject.toml | Package description PIP| Supported by Python |



## 5. Development tools, environment, build executables

Some development tools are needed with this package, listed below:

* [Pyinstaller](https://pyinstaller.org).
* [Opencv](https://opencv.org/).
* [Curses for Python](https://docs.python.org/3/howto/curses.html) ```pip install windows-curses```.
* [7zip](https://7ziphelp.com/).

### 5.1 Notes for developers

You can use the __main__.py for execute as first time in src/ak_frame_extractor/_ _ main _ _.py Configure the path of
the project, if you use Pycharm, put your folder root like this:
![ak_frame_extractor](https://github.com/GRAP-UdL-AT/ak_frame_extractor/blob/main/img/configuration_pycharm.png?raw=true)

### 5.2 Creating virtual environment Linux

```
python3 -m venv ./venv
source ./venv/bin/activate
pip install --upgrade pip
pip install -r requirements_linux.txt
```

### 5.3 Creating virtual environment  Windows

```
%userprofile%"\AppData\Local\Programs\Python\Python38\python.exe" -m venv ./venv
venv\Scripts\activate.bat
pip install --upgrade pip
pip install -r requirements_windows.txt
```

** If there are some problems in Windows, follow [this](https://github.com/etiennedub/pyk4a/) **

```
pip install pyk4a --no-use-pep517 --global-option=build_ext --global-option="-IC:\Program Files\Azure Kinect SDK v1.4.1\sdk\include" --global-option="-LC:\Program Files\Azure Kinect SDK v1.4.1\sdk\windows-desktop\amd64\release\lib"
```

## 5.4 Building PIP package

We are working to offer Pypi support for this package. At this time this software can be built by scripts automatically.

### 5.4.1 Build packages

```
py -m pip install --upgrade build
build_pip.bat
```

### 5.4.2 Download PIP package

```
pip install package.whl
```

### 5.4.3 Run ak_frame_extractor

```
python -m ak_frame_extractor.py
```

## 5.4 Building .EXE for Windows 10

```
build_win.bat
```

After the execution of the script, a new folder will be generated inside the project **"/dist"**. You can copy **
ak_frame_extracted_f/** or a compressed file **"ak_frame_Extractor_f.zip"** to distribute.

### 5.6 Package distribution format

Explain about packages distribution.

| Package type | Package |  Url |  Description | 
|--------------|---------|------|------| 
| Windows      | .EXE    | .EXE | Executables are stored under build/ | 
| Linux        | .deb    | .deb | NOT IMPLEMENTED YET| 
| PIP          | .whl    | .whl | PIP packages are stored in build/ |

## Authorship

Please contact authors to report bugs [https://www.linkedin.com/in/juan-carlos-miranda-py/](https://www.linkedin.com/in/juan-carlos-miranda-py/)

## Citation

If you find this code useful, please consider citing:

```
@article{miranda2018clasificacion,
  title={Clasificaci{\'o}n autom{\'a}tica de naranjas por tama{\~n}o y por defectos utilizando t{\'e}cnicas de visi{\'o}n por computadora},
  journal={Universidad Nacional de Asunci{\'o}n, San Lorenzo},
  year={2018},    
  doi = {http://dx.doi.org/10.13140/RG.2.2.15456.35845},
  url = {https://www.researchgate.net/publication/326551993_CLASIFICACION_AUTOMATICA_DE_NARANJAS_POR_TAMANO_Y_POR_DEFECTOS_UTILIZANDO_TECNICAS_DE_VISION_POR_COMPUTADORA},
  author={Miranda, Juan Carlos and Legal-Ayala, H},
  keywords = {computer vision, image processing, segmentation, classification, machine learning},
  abstract = {...}
}
```

## Acknowledgements

This work is a result of the **BECA08-25** granted by [Consejo Nacional de Ciencia y Tecnología (CONACYT)](https://repositorio.conacyt.gov.py/handle/20.500.14066/).
