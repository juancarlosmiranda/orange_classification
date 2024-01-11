% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
% IMPLEMENTA MEJORAS EN LA EXTRACCION DE LS DEFECTOS, DADO QE TOMA LAS
% IMAGENES ORIGINALES EN RGB Y SEGMENTA LOS VALORES MARCADOS POR EL EXPERTO
%
% Genera imagenes de regiones previamente marcadas por un experto en forma
% MANUAL con un editor de imágenes.
% Es un proceso previo a la extraccion automatizada de características.
% Se asume que un experto marcó las frutas a mano con colores.
% Como salida se producen imágenes. Utiliza en paralelo imagenes
% originales e imágenes marcadas.
% Genera el paso previo a la creacion del archivo de ENTRENAMIENTO PARA EL
% CLASIFICADOR DE DEFECTOS.

%% Ajuste de parámetros iniciales
clc; clear all; close all;
 
 %% Definicion de estructura de directorios 
HOME=fullfile('C:','Users','Usuari','development','orange_classification');
pathPrincipal=fullfile(HOME,'OrangeResults','byDefects','PSMet2','SegMarkExp');
pathEntradaImagenesMarcas=fullfile(HOME,'OrangeResults','inputMarked');
pathEntradaImagenes=fullfile(HOME,'OrangeResults','inputToLearn');
pathEntradaMarca=fullfile(HOME,'OrangeResults','inputTraining');
pathConfiguracion=fullfile(pathPrincipal,'conf');
pathAplicacion=fullfile(pathPrincipal,'tmpToLearn'); %se utiliza para situar las imagenes de calibracion
%pathAplicacionSiluetas=fullfile(pathAplicacion,'sFrutas');
%pathResultados=fullfile(pathPrincipal,'output');%se guardan los resultados

nombreImagenP='nombreImagenP';

 %% Nombres de archivos de configuracion
 % trabajan con métodos para equivalencia con las 4 vistas
archivoConfiguracion=fullfile(pathConfiguracion,'20170916configuracion.xml'); %Para coordenadas iniciales en tratamiento de imagenes
archivoCalibracion=fullfile(pathConfiguracion,'20170916calibracion.xml'); %para indicar al usuario en la parte final la calibracion
  
 %% Definicion de los cuadros, según numeración 
Fila1=readConfiguration('Fila1', archivoConfiguracion);
FilaAbajo=readConfiguration('FilaAbajo', archivoConfiguracion);

%Cuadro 1 abajo
Cuadro1_lineaGuiaInicialFila=readConfiguration('Cuadro1_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro1_lineaGuiaInicialColumna=readConfiguration('Cuadro1_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro1_espacioFila=readConfiguration('Cuadro1_espacioFila', archivoConfiguracion);
Cuadro1_espacioColumna=readConfiguration('Cuadro1_espacioColumna', archivoConfiguracion);

%Cuadro 2 izquierda
Cuadro2_lineaGuiaInicialFila=readConfiguration('Cuadro2_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro2_lineaGuiaInicialColumna=readConfiguration('Cuadro2_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro2_espacioFila=readConfiguration('Cuadro2_espacioFila', archivoConfiguracion);
Cuadro2_espacioColumna=readConfiguration('Cuadro2_espacioColumna', archivoConfiguracion);

%Cuadro 3 centro
Cuadro3_lineaGuiaInicialFila=readConfiguration('Cuadro3_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro3_lineaGuiaInicialColumna=readConfiguration('Cuadro3_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro3_espacioFila=readConfiguration('Cuadro3_espacioFila', archivoConfiguracion);
Cuadro3_espacioColumna=readConfiguration('Cuadro3_espacioColumna', archivoConfiguracion);

%Cuadro 4 derecha
Cuadro4_lineaGuiaInicialFila=readConfiguration('Cuadro4_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro4_lineaGuiaInicialColumna=readConfiguration('Cuadro4_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro4_espacioFila=readConfiguration('Cuadro4_espacioFila', archivoConfiguracion);
Cuadro4_espacioColumna=readConfiguration('Cuadro4_espacioColumna', archivoConfiguracion);

%%carga en memoria para que sea mas rapido
ArrayCuadros=[Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila, Cuadro1_espacioColumna, Cuadro1_espacioFila;
Cuadro2_lineaGuiaInicialColumna, Cuadro2_lineaGuiaInicialFila, Cuadro2_espacioColumna, Cuadro2_espacioFila;
Cuadro3_lineaGuiaInicialColumna, Cuadro3_lineaGuiaInicialFila, Cuadro3_espacioColumna, Cuadro3_espacioFila;
Cuadro4_lineaGuiaInicialColumna, Cuadro4_lineaGuiaInicialFila, Cuadro4_espacioColumna, Cuadro4_espacioFila;
0,0,0,0
];

%% CONFIGURACIONES DE PROCESAMIENTO DE IMAGENES
areaObjetosRemoverBR=5000; % para siluetas y detección de objetos. Tamaño para realizar granulometria
% configuracion de umbrales
canalLMin = 0.0; canalLMax = 96.653; canalAMin = -23.548; canalAMax = 16.303; canalBMin = -28.235; canalBMax = -1.169; %parametros de umbralizacion de fondo
% ----- FIN Definicion de topes

%% Remover archivos antiguos, borrar archivos antiguos
% TODO: SE DEBE CREAR UN SCRIPT QUE HAGA NUEVAMENTE LA ESTRUCTURA DE
% tmpToLearn/
fprintf('LIMPIANDO IMAGENES ANTIGUAS \n');
removeFiles(fullfile(pathAplicacion,'sFrutas','*.jpg'));
removeFiles(fullfile(pathAplicacion,'ROIDefC','*.jpg'));
removeFiles(fullfile(pathAplicacion,'ROIDefBin','*.jpg'));
removeFiles(fullfile(pathAplicacion,'ROICalyxC','*.jpg'));
removeFiles(fullfile(pathAplicacion,'ROICalyxBin','*.jpg'));
removeFiles(fullfile(pathAplicacion,'MROI','*.jpg'));
removeFiles(fullfile(pathAplicacion,'MRM','*.jpg'));
removeFiles(fullfile(pathAplicacion,'MDefColor','*.jpg'));
removeFiles(fullfile(pathAplicacion,'MDefBin','*.jpg'));
removeFiles(fullfile(pathAplicacion,'MCalyxColor','*.jpg'));
removeFiles(fullfile(pathAplicacion,'MCalyxBin','*.jpg'));
removeFiles(fullfile(pathAplicacion,'ISFrutas','*.jpg'));
removeFiles(fullfile(pathAplicacion,'IROI','*.jpg'));
removeFiles(fullfile(pathAplicacion,'IRM','*.jpg'));
removeFiles(fullfile(pathAplicacion,'IBR','*.jpg'));
removeFiles(fullfile(pathAplicacion,'cDefectos','*.jpg'));
removeFiles(fullfile(pathAplicacion,'cCalyx','*.jpg'));
%pause
%% --------------------------------------------------------------------
listado=dir(fullfile(pathEntradaMarca,'*.jpg')); %recorre el listado de las imagenes marcadas
%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    %TODO:13/12/2023 add banner with user information total images
    %processed!!
    fprintf('SEPARANDO REGIONES MARCADAS MANUALMENTE POR EL EXPERTO-> %s \n',listado(n).name);    
    nombreImagenP=listado(n).name;    
    %Se utiliza para separar las marcas hechas por expertos, los cuales
    %segmentaron con color azul los defectos en las frutas. Paralelamente
    %se tienen las imagenes originales, para poder obtener características
    %reales de los defectos en las frutas.
    ProcessMarks(pathEntradaImagenes, pathEntradaMarca, pathAplicacion, nombreImagenP, ArrayCuadros, areaObjetosRemoverBR, canalLMin, canalLMax, canalAMin, canalAMax, canalBMin, canalBMax )    
    %GENERA imagenes marcadas
    ExtractMarkedRegions(pathEntradaImagenes, pathAplicacion, nombreImagenP)
    %if n==1
    %    break;
    %end;
end %

fprintf('SE HAN SEPARADO LAS REGIONES MARCADAS POR EL EXPERTO \n');
fprintf('Debe correr el proceso para extraer las características PROGRAM_NAME_HERE!!!! \n');