% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
%{
% Genera archivos con características de defectos y calyx, los cuales son utilizados
para obtener datos de: color, textura y geometria de defectos y calyx.
REQUIRE DE UN PROCESO PREVIO, que genera imagnes de defectos en colores y sus siluetas.

Cada imagen en un directorio base, cuenta con sub imágenes de regiones e
imágenes de siluetas. Ejemplo:
001.jpg es la imagen principal, existen imágenes de las regiones R1..R4
para lo defectos y a su vez exiten imágenes específicas para sus siluetas
de defectos.
La función asume que hubo un procesamiento previo, en el cual se generaron
imágenes desde las marcas en colores dibujadas por e experto.
%}

%% Ajuste de parámetros iniciales
clc; clear all; close all;
 
 %% Definicion de estructura de directorios 
%HOME=strcat(pwd,'/');
HOME=fullfile('C:','Users','Usuari','development','orange_classification');
pathPrincipal=fullfile(HOME,'OrangeResults','byDefects','PSMet2','SegMarkExp'); %Toma como entradas las imágenes generadas con el proceso anterior
pathPrincipal2=fullfile(HOME,'OrangeResults', 'byDefects','PSMet2','SegMarkExpExtraction'); %

% pathPrincipal='/home/usuario/ml/clasDefectos4/';
pathEntradaImagenesTraining=fullfile(HOME,'OrangeResults','inputTraining');
%pathEntradaImagenesTraining='/home/usuario/ml/inputToLearnEntrenar/';
 
%pathAplicacion=strcat(pathPrincipal,'tmpToLearn/MARCAS/'); %directorio de alojamiento de imagenes
pathAplicacion=fullfile(pathPrincipal,'tmpToLearn'); %directorio de alojamiento de imagenes
 
 
%% Definicion de variables para resguardo de defectos y calyx
%pathcDefectos=strcat(pathAplicacion,'cDefectos/'); %defectos en color
%pathdefBin=strcat(pathAplicacion,'defBin/'); %siluetas de defectos en binario
 
pathcDefectos=fullfile(pathAplicacion,'cDefectos'); %defectos en color
pathdefBin=fullfile(pathAplicacion,'MDefBin'); %siluetas de defectos en binario

 
%pathcalyxColor=strcat(pathAplicacion,'calyxColor/'); %calyx en color
%pathcalyxBin=strcat(pathAplicacion,'calyxBin/'); %siluetas de calyx en binario
pathcalyxColor=fullfile(pathAplicacion,'cCalyx'); %calyx en color
pathcalyxBin=fullfile(pathAplicacion,'MCalyxBin'); %siluetas de calyx en binario
 
nombreImagenP='nombreImagenP';

% color de defectos para las regiones R1..R4
postfijocDefectos1='_soC1.jpg';
postfijocDefectos2='_soC2.jpg';
postfijocDefectos3='_soC3.jpg';
postfijocDefectos4='_soC4.jpg';
  
% siluetas defectos para las regiones R1..R4
postfijodefBin1='_DEFB1.jpg';
postfijodefBin2='_DEFB2.jpg';
postfijodefBin3='_DEFB3.jpg';
postfijodefBin4='_DEFB4.jpg';

% COLOR DE CALYX
postfijocalyxColor1='_CALC1.jpg';
postfijocalyxColor2='_CALC2.jpg';
postfijocalyxColor3='_CALC3.jpg';
postfijocalyxColor4='_CALC4.jpg';
  
% BINARIO DE CALYX
postfijocalyxBin1='_CALB1.jpg';
postfijocalyxBin2='_CALB2.jpg';
postfijocalyxBin3='_CALB3.jpg';
postfijocalyxBin4='_CALB4.jpg';
 
pathResultados=fullfile(pathPrincipal2,'output');%directorio para resultados
%archivoVectorCalyx=strcat(pathResultados,'aCalyx.csv'); %archivo de salida para calyx
%archivoVectorDef=strcat(pathResultados,'aDef.csv'); %archivo de salida para defectos
archivoBDDEFECTOSCALYX=fullfile(pathResultados,'BDDEFECTOSCALYX.csv'); %salida completa

%% Nombres de archivos de configuracion
% trabajan con métodos para equivalencia con las 4 vistas

%% Remover archivos antiguos, borrar archivos antiguos
%removeFiles(archivoVectorCalyx); %elimina caracteristicas anteriores
%removeFiles(archivoVectorDef);
removeFiles(archivoBDDEFECTOSCALYX);

%% --------------------------------------------------------------------
%carga del listado de nombres
listado=dir(fullfile(pathEntradaImagenesTraining,'*.jpg'));


%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    fprintf('Extrayendo características para entrenamiento-> %s \n',listado(n).name);
    nombreImagenP=listado(n).name;
    %    fin = strfind(nombreImagenP, '_');
    %    nombreImagenOriginal=nombreImagenP(1:fin-1);
    
    nombreImagenOriginal=nombreImagenP;
    %% Procesamiento de calyx en color y binario
    % Se asume que existen imágenes con o sin defectos por cada region
    % R1..R4.
    nombreImagencalyxColor1=fullfile(pathcalyxColor,strcat(nombreImagenOriginal,postfijocalyxColor1));
    nombreImagencalyxColor2=fullfile(pathcalyxColor,strcat(nombreImagenOriginal,postfijocalyxColor2));
    nombreImagencalyxColor3=fullfile(pathcalyxColor,strcat(nombreImagenOriginal,postfijocalyxColor3));
    nombreImagencalyxColor4=fullfile(pathcalyxColor,strcat(nombreImagenOriginal,postfijocalyxColor4));
    
    nombreImagencalyxBin1=fullfile(pathcalyxBin,strcat(nombreImagenOriginal,postfijocalyxBin1));
    nombreImagencalyxBin2=fullfile(pathcalyxBin,strcat(nombreImagenOriginal,postfijocalyxBin2));
    nombreImagencalyxBin3=fullfile(pathcalyxBin,strcat(nombreImagenOriginal,postfijocalyxBin3));
    nombreImagencalyxBin4=fullfile(pathcalyxBin,strcat(nombreImagenOriginal,postfijocalyxBin4));
    
    %% llamado para la extraccion de calyx
    etiqueta='CALYX';
    defectDetectionExp( 1, nombreImagencalyxBin1, nombreImagencalyxColor1, archivoBDDEFECTOSCALYX, nombreImagenOriginal, etiqueta);
    defectDetectionExp( 2, nombreImagencalyxBin2, nombreImagencalyxColor2, archivoBDDEFECTOSCALYX, nombreImagenOriginal, etiqueta);
    defectDetectionExp( 3, nombreImagencalyxBin3, nombreImagencalyxColor3, archivoBDDEFECTOSCALYX, nombreImagenOriginal, etiqueta);
    defectDetectionExp( 4, nombreImagencalyxBin4, nombreImagencalyxColor4, archivoBDDEFECTOSCALYX, nombreImagenOriginal, etiqueta);
    
    %% procesamiento de defectos en color y en binario
    nombreImagencDefectos1=fullfile(pathcDefectos,strcat(nombreImagenOriginal,postfijocDefectos1));
    nombreImagencDefectos2=fullfile(pathcDefectos,strcat(nombreImagenOriginal,postfijocDefectos2));
    nombreImagencDefectos3=fullfile(pathcDefectos,strcat(nombreImagenOriginal,postfijocDefectos3));
    nombreImagencDefectos4=fullfile(pathcDefectos,strcat(nombreImagenOriginal,postfijocDefectos4));
    
    % siluetas
    nombreImagendefBin1=fullfile(pathdefBin,strcat(nombreImagenOriginal, postfijodefBin1));
    nombreImagendefBin2=fullfile(pathdefBin,strcat(nombreImagenOriginal, postfijodefBin2));
    nombreImagendefBin3=fullfile(pathdefBin,strcat(nombreImagenOriginal, postfijodefBin3));
    nombreImagendefBin4=fullfile(pathdefBin,strcat(nombreImagenOriginal, postfijodefBin4));
    
    
    %% llamado para la extraccion de defectos
    
    etiqueta='DEFECTOS';
    defectDetectionExp( 1, nombreImagendefBin1, nombreImagencDefectos1, archivoBDDEFECTOSCALYX, nombreImagenOriginal, etiqueta);
    defectDetectionExp( 2, nombreImagendefBin2, nombreImagencDefectos2, archivoBDDEFECTOSCALYX, nombreImagenOriginal, etiqueta);
    defectDetectionExp( 3, nombreImagendefBin3, nombreImagencDefectos3, archivoBDDEFECTOSCALYX, nombreImagenOriginal, etiqueta);
    defectDetectionExp( 4, nombreImagendefBin4, nombreImagencDefectos4, archivoBDDEFECTOSCALYX, nombreImagenOriginal, etiqueta);
    
    
    %if n==1
    %     break;
    %end;
end %

total=size(listado);

fprintf('\n -------------------------------- \n');
fprintf('Se procesaron un total de %i archivos del directorio %s \n',total(1), pathEntradaImagenesTraining);
fprintf('Los DEFECTOS se guardaron en el archivo %s \n', archivoBDDEFECTOSCALYX);
%fprintf('En el archivo %s se guardaron los DEFECTOS\n', archivoVectorDef);
%fprintf('En el archivo %s se guardaron los CALYX\n', archivoVectorCalyx);
fprintf('\n -------------------------------- \n');
