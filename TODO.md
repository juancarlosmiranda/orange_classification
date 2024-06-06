# TODO LIST
## TODO - documentación
### Presentación del repositorio
~Colocar el enlace a la tesis en la página del CONACYT.~
~Subir el update a la página de Researchgate~
Hacer un readme para ejecutar.
Subir las imágenes en un zenodo
Subir fotografías y un video del funcionamiento.
Crear la secuencia de pasos que vaya enlazada con la tesis para replicar.

### TODO - organización de código
~Separar el DATASET ORIGINAL de los elementos pre-procesados.~
~Separar dataset de salidas~


Quitar las cadenas hardcoded
Corregir los paths, pasar a la instrucción fullfile y addpath. Trabajar con addpath y fullfile
Crear un script instalador que cree la secuencia de directorios automaticamente.
Translate to matlab script to clean folders
Traducir campos de Training\conf\20170916configuracion.xml
Traducir nombres de variables
Traducir nombres de funciones.
Traducir nombres de archivos
Traducir nombres de campos en archivos.
Traducir comentarios del texto.
Traducir los datos del .csv.
Traducir los comentarios
Limpiar el código de comentarios antiguos.
Actualizar las cabeceras de los archivos de código.
Por último, colocar en librerías comunes las funciones que se han repetido como ser: removeFiles.m
Colocar un README por cada carpeta
Faltaría un menu unificador para todos los procesos.
Cambiar los separadores a punto y coma.
hACER UN GRÁFICO GENERAL DE USO
En "detectROICandidates2", solucionar los problemas del path
Llegado el momento, separar el entrenamiento del pipeline de detección. Agregr una función que lea el modelo entrenado desde un archivo.
Colocar las etiquetas DEFECTOS Y CALYX en variables, porque están hardcoded
Los métodos de segmentación se repiten, se debe organizar como librerías. Por ejemplo SEGMENTATION/ARCHIVO01.m
Hacer un mapa de las coordenadas XY.
Hacer un listado de los conceptos aplicados para generar una receta con 
tareas habituales MATLAB

Arreglar "detectROICandidates2.m". para que tome datos de un clasificador entrenado. Subir a niveles superiores las 
rutas al arhivo entrenado. De tal manera que la función levante desde disco al inicio el pre-trained.
Afecta "MainDefDetectONLINE4R.m", "ExtractDefDetectImgSoft.m".
Probar una capsula de codeocean.
Organizar las variables de los módulos, corregir el gráfico de las carpetas

## Folders to check
Carpeta con los respectivos módulos.
Verificar la carpeta bySize/ y byDefects/


bySize
---------
Arreglar cabeceras de archivos.
Arreglar rutas.
Traducir nombres de variables.
Traducir nombres de funciones y cambiar los archivos.
Hacer el listado con los pasos para ejecución.
Colocar los nombres de las variables según los módulos
Agregar para la creación de directorios en settings. Suplantar las cadenas de PATH para tomar de una librería inicial. Sin tener que configurar en cada script.
Agregar todas las librerías comunes a un directorio /lib, por ejemplo "BRemovalLAB.m".


Segunda etapa de refatory
----------------------------
Por último, actualizar la fecha del refactory.
No tiene que quedar variables en castellano.
Pasar el embellecedor de código.
Arreglar los nombres de variable del rectangulo en objectDetection2.m. Conviene
que se arregle el nombre una vez migradas a una directorio común. x,y,w,h

Ejemplo de relative path. https://la.mathworks.com/matlabcentral/answers/250997-how-to-use-relative-path-to-use-matlab-file-in-another-computer
currentFile = mfilename( 'fullpath' );

[pathstr,currentFilenameScript,par_03] = fileparts( currentFile );
Sería terminar de organizar el c´ódigo y resolver lo del path en la segunda vuelta.

ojo_eh=addpath(fullfile(pathstr,'..','..','..'))

ojo_eh=fullfile(pathstr,'..','..','..')
[pathstr,currentFilenameScript,par_03] = fileparts( ojo_eh );
ojo_eh=fullfile(pathstr,'..','..','..', 'libs')

https://stackoverflow.com/questions/36060074/how-to-get-relative-path-to-folder-containing-a-m-file


## Code to verify

Calibration4R/
clasSize2ML/
clasSize24R/
clasSizeUM/
conf/
Training24R/

## Code translated and reviewed


Borrar los directorios y crearlos
