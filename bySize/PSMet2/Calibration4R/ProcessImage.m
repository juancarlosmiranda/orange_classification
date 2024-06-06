function [ ] = ProcessImage(pathImages, outputPath, imageNameP, archivoCalibracion, vectorFile, rectangleList, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax )
%
% Project: AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING
% COMPUTER VISION TECHNIQUES
%
% Author: Juan Carlos Miranda. https://github.com/juancarlosmiranda/
% Date: 2018
% Update:  December 2023
%
% Description:
%
% This process is carried out for each image that is received as input. Data are obtained by applying morphological operations and extracting geometric features.
% Intermediate results are saved so that images of the process can be obtained.
%
% Usage:
%
% ProcessImage(pathImagesSamples, pathCalibration, imageNameP , pathCalibrationFile, pathVectorFile, rectangleList, objectAreaBR, LchannelMin, LchannelMax, AChannelMin, AChannelMax, BChannelMin, BChannelMax);
%
% -----------------------------------------------------------------------

initialImage=fullfile(pathImages,imageNameP);

%% Setting up the directory folder structure
outputPathPR=fullfile(outputPath,'pr'); % pre procesing
outputPathBR=fullfile(outputPath,'br'); % background removal
outputPathROI=fullfile(outputPath,'roi'); % region of interest
outputPathSiFruits=fullfile(outputPath,'sFrutas');
outputPathBaRemoved=fullfile(outputPath,'removido');

outputPath4=fullfile(outputPath,'sDefectos');
outputPath5=fullfile(outputPath,'defectos');
%pathAplicacion6=fullfile(pathAplicacion,'cDefectos');

% --- NAME OF INTERMEDIATE IMAGES ---
% with background removed
%imageNamePR=fullfile(outputPathPR,strcat(imageNameP,'_','PR.jpg'));
imageNameBR=fullfile(outputPathBR,strcat(imageNameP,'_','BR.jpg'));
imageNameROI=fullfile(outputPathROI,strcat(imageNameP,'_','RO.jpg'));
imageNameF=fullfile(outputPathROI,strcat(imageNameP,'_','I.jpg'));

% prefix for images of removed background and silhouettes of removed backgrounds in object detection
imageNameSilhouettesN=fullfile(outputPathSiFruits,strcat(imageNameP,'_','sN'));
imageNameRemoved=fullfile(outputPathBaRemoved,strcat(imageNameP,'_','rm'));

% Siluetas operaciones morfologicas
imageNameSilhouettesN1=fullfile(outputPathSiFruits,strcat(imageNameP,'_','sN1.jpg'));
imageNameSilhouettesN2=fullfile(outputPathSiFruits,strcat(imageNameP,'_','sN2.jpg'));
imageNameSilhouettesN3=fullfile(outputPathSiFruits,strcat(imageNameP,'_','sN3.jpg'));
imageNameSilhouettesN4=fullfile(outputPathSiFruits,strcat(imageNameP,'_','sN4.jpg'));

% nombres de archivos con objetos removidos
%nombreImagenRemovida1=strcat(outputPathBaRemoved,imageNameP,'_','rm1.jpg');
%nombreImagenRemovida2=strcat(outputPathBaRemoved,imageNameP,'_','rm2.jpg');
%nombreImagenRemovida3=strcat(outputPathBaRemoved,imageNameP,'_','rm3.jpg');
%nombreImagenRemovida4=strcat(outputPathBaRemoved,imageNameP,'_','rm4.jpg');


%% salida segmentacion
%nombreImagenSalida1=strcat(outputPath4,imageNameP,'_','so1.jpg');
%nombreImagenSalida2=strcat(outputPath4,imageNameP,'_','so2.jpg');
%nombreImagenSalida3=strcat(outputPath4,imageNameP,'_','so3.jpg');
%nombreImagenSalida4=strcat(outputPath4,imageNameP,'_','so4.jpg');

%% salida defectos
%nombreImagenDefectos1=strcat(outputPath5,imageNameP,'_','soM1.jpg');
%nombreImagenDefectos2=strcat(outputPath5,imageNameP,'_','soM2.jpg');
%nombreImagenDefectos3=strcat(outputPath5,imageNameP,'_','soM3.jpg');
%nombreImagenDefectos4=strcat(outputPath5,imageNameP,'_','soM4.jpg');


%% GRANULOMETRIAS
%areaObjetosRemoverBR=5000; % para siluetas y detección de objetos. Tamaño para realizar granulometria
objecSize=2000; %granulometria para extraccion de objetos segun car geometricas

%% ----- INICIO Definicion de topes
% Para definicion de rectangulos
% Se calcula el tamaño de la imagen para luego aplicar las lineas de
% cortes.
% obtener el tamaño


%% -- BEGIN IMAGE PROCESSING ----------------------------------
%% Background removed
%[X,Y,W,H] top-left corner X,Y; W=horizontal width, H= vertical height
% * ---------> X
% |  (x,y)-----|
% |  |         |
% |  |------ W,H
% |
% Y
% V
% It follows this sintax xmin,ymin,width,height
rectangle1_X=rectangleList(1,1);
rectangle1_Y=rectangleList(1,2);
rectangle1_W=rectangleList(1,3);
rectangle1_H=rectangleList(1,4);
%imagenInicial
%imagenNombrePR
%BRPreProc(imagenInicial, imagenNombrePR, Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila-2, Cuadro1_espacioColumna, Cuadro1_espacioFila);

fprintf('BR -> Background segmentation --> \n'); % output an image with 4 silhouettes
%BRemovalLAB(initialImage, imageNameBR, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax,rectangle1_X, rectangle1_Y-2, rectangle1_W, rectangle1_H);
BRemovalLAB(initialImage, imageNameBR, imageNameF, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax,rectangle1_X, rectangle1_Y-2, rectangle1_W, rectangle1_H);


%% Removing background
fprintf('BR -> Removing background, separating Region of Interest (ROI) --> \n'); % output an image with 4 objects
backgroundRemoval4(initialImage, imageNameBR, imageNameROI);

%% Working with cropped ROIs
fprintf('BR -> Detection of objects in frames. Cropping ROI and ROI silhouettes --> \n'); % output 4 images of an object each assigns numbers of objects according to membership in the box
objectDetection2(imageNameBR, imageNameROI, imageNameSilhouettesN, imageNameRemoved, rectangleList );

%% -- END IMAGE PROCESSING ----------------------------------


%% -- BEGIN DEFECTS FEATURES EXTRACTION ----------------------------------
%% Segmentacion de mascara para obtener defectos aislados de ROI
%fprintf('Segmentacion de mascara para obtener defectos aislados de ROI --> \n');
% Esta es la funcion que da buenos resultados
%%Imagen 1
%   SegmentacionSobel1(nombreImagenRemovida1, nombreImagenSalida1);
%   SegmentacionSobel1(nombreImagenRemovida2, nombreImagenSalida2);
%   SegmentacionSobel1(nombreImagenRemovida3, nombreImagenSalida3);
%   SegmentacionSobel1(nombreImagenRemovida4, nombreImagenSalida4);

%   SegmentacionPrewitt(nombreImagenRemovida1, nombreImagenSalida1);
%   SegmentacionPrewitt(nombreImagenRemovida2, nombreImagenSalida2);
%   SegmentacionPrewitt(nombreImagenRemovida3, nombreImagenSalida3);
%   SegmentacionPrewitt(nombreImagenRemovida4, nombreImagenSalida4);

%%   extraerRegionManchasPrewitt( nombreImagenSalida1, nombreImagenDefectos1, tamanoManchas);
%   extraerRegionManchasPrewitt( nombreImagenSalida2, nombreImagenDefectos2, tamanoManchas);
%   extraerRegionManchasPrewitt( nombreImagenSalida3, nombreImagenDefectos3, tamanoManchas);
%   extraerRegionManchasPrewitt( nombreImagenSalida4, nombreImagenDefectos4, tamanoManchas);
%% Esto no da tan buenos resultados, luego de experimentar, el procedimiento 1 es el mejor
%   SegmentacionSobel2(nombreImagenRemovida1, nombreImagenSalida1);
%   SegmentacionSobel2(nombreImagenRemovida2, nombreImagenSalida2);
%   SegmentacionSobel2(nombreImagenRemovida3, nombreImagenSalida3);
%   SegmentacionSobel2(nombreImagenRemovida4, nombreImagenSalida4);

%% Separación de defectos
%fprintf('Separación guardarAVSyze4Rde defectos en color --> \n');
%removerFondo4(nombreImagenRemovida1, nombreImagenSalida1, nombreImagenDefectos1);
%removerFondo4(nombreImagenRemovida2, nombreImagenSalida2, nombreImagenDefectos2);
%removerFondo4(nombreImagenRemovida3, nombreImagenSalida3, nombreImagenDefectos3);
%removerFondo4(nombreImagenRemovida4, nombreImagenSalida4, nombreImagenDefectos4);

%% -- END DEFECTS FEATURES EXTRACTION ----------------------------------

%% By Size --> Extraccion de caracteristicas
pixelmmR1=readConfiguration('pixelLinealR1', archivoCalibracion);
pixelmmR2=readConfiguration('pixelLinealR2', archivoCalibracion);
pixelmmR3=readConfiguration('pixelLinealR3', archivoCalibracion);
pixelmmR4=readConfiguration('pixelLinealR4', archivoCalibracion);

%% Declaracion de variables con valores de pixeles
%% Recorte 1
sumAreaPxR1=0;
diameterPxR1=0;
majorAxisPxR1=0;
minorAxisPxR1=0;

sumaAreammR1=0.0;
diametermmR1=0.0;
majorAxismmR1=0.0;
minorAxismmR1=0.0;

%% Recorte 2
sumAreaPxR2=0;
diameterPxR2=0;
majorAxisPxR2=0;
minorAxisPxR2=0;

sumaAreammR2=0.0;
diametermmR2=0.0;
mayorAxismmR2=0.0;
minorAxismmR2=0.0;

%% Recorte 3
sumAreaPxR3=0;
diameterPxR3=0;
majorAxisPxR3=0;
minorAxisPxR3=0;

sumaAreammR3=0.0;
diametermmR3=0.0;
mayorAxismmR3=0.0;
minorAxismmR3=0.0;

%% Recorte 4
sumAreaPxR4=0;
diameterPxR4=0;
majorAxisPxR4=0;
minorAxisPxR4=0;

sumaAreammR4=0.0;
diametermmR4=0.0;
majorAxismmR4=0.0;
minorAxismmR4=0.0;

%% Extracción de características
fprintf('Extraccion de características geometricas--> \n');
fprintf('Extraccion de características geometricas Recorte 1 --> \n');
[ sumAreaPxR1, diameterPxR1, majorAxisPxR1, minorAxisPxR1]=extractGeoFeatures4R( imageNameSilhouettesN1,objecSize);
fprintf('Extraccion de características geometricas Recorte 2 --> \n');
[ sumAreaPxR2, diameterPxR2, majorAxisPxR2, minorAxisPxR2]=extractGeoFeatures4R( imageNameSilhouettesN2,objecSize);
fprintf('Extraccion de características geometricas Recorte 3 --> \n');
[ sumAreaPxR3, diameterPxR3, majorAxisPxR3, minorAxisPxR3]=extractGeoFeatures4R( imageNameSilhouettesN3,objecSize);
fprintf('Extraccion de características geometricas Recorte 4 --> \n');
[ sumAreaPxR4, diameterPxR4, majorAxisPxR4, minorAxisPxR4]=extractGeoFeatures4R( imageNameSilhouettesN4,objecSize);


%% Cálculo para unidades de medida
diametermmR1=diameterPxR1*pixelmmR1;
%sumaAreammR1=sumaAreaPxR1*pixelCuadradoR1;
majorAxismmR1=majorAxisPxR1*pixelmmR1;
minorAxismmR1=minorAxisPxR1*pixelmmR1;

diametermmR2=diameterPxR2*pixelmmR2;
%sumaAreammR2=sumaAreaPxR2*pixelCuadradoR2;
mayorAxismmR2=majorAxisPxR2*pixelmmR2;
minorAxismmR2=minorAxisPxR2*pixelmmR2;

diametermmR3=diameterPxR3*pixelmmR3;
%sumaAreammR3=sumaAreaPxR3*pixelCuadradoR3;
mayorAxismmR3=majorAxisPxR3*pixelmmR3;
minorAxismmR3=minorAxisPxR3*pixelmmR3;

diametermmR4=diameterPxR4*pixelmmR4;
%sumaAreammR4=sumaAreaPxR4*pixelCuadradoR4;
majorAxismmR4=majorAxisPxR4*pixelmmR4;
minorAxismmR4=minorAxisPxR4*pixelmmR4;


%% Guardado en archivo
clase='SIN_CLASIFICAR';
fprintf('Características obtenidas --> \n');
fprintf('%s, %10.4f, %10.4f, %10.4f, %10.4f,%10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n', initialImage, pixelmmR1, pixelmmR2, pixelmmR3, pixelmmR4, sumAreaPxR1, sumAreaPxR2, sumAreaPxR3, sumAreaPxR4, diameterPxR1, diameterPxR2, diameterPxR3, diameterPxR4, majorAxisPxR1, majorAxisPxR2, majorAxisPxR3, majorAxisPxR4, minorAxisPxR1, minorAxisPxR2, minorAxisPxR3, minorAxisPxR4, diametermmR1, diametermmR2, diametermmR3, diametermmR4, majorAxismmR1, mayorAxismmR2, mayorAxismmR3, majorAxismmR4, minorAxismmR1, minorAxismmR2, minorAxismmR3, minorAxismmR4, clase);

% Se guardan primero todo lo relacionado a pixeles, luego las conversiones
% a milimetros
fila=sprintf('%s, %10.4f, %10.4f, %10.4f, %10.4f,%10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n', initialImage, pixelmmR1, pixelmmR2, pixelmmR3, pixelmmR4, sumAreaPxR1, sumAreaPxR2, sumAreaPxR3, sumAreaPxR4, diameterPxR1, diameterPxR2, diameterPxR3, diameterPxR4, majorAxisPxR1, majorAxisPxR2, majorAxisPxR3, majorAxisPxR4, minorAxisPxR1, minorAxisPxR2, minorAxisPxR3, minorAxisPxR4, diametermmR1, diametermmR2, diametermmR3, diametermmR4, majorAxismmR1, mayorAxismmR2, mayorAxismmR3, majorAxismmR4, minorAxismmR1, minorAxismmR2, minorAxismmR3, minorAxismmR4, clase);
saveAVSyze4R( vectorFile, fila)

% -----------------------------------------------------------------------
fprintf('Extraccion de características Defectos--> \n');
%[ sumaArea, redondez, diametro, ejeMayor, ejeMenor, totalPixelesManchas, totalManchas ] = extraerCarPrewitt( nombreImagenRemovida1, nombreImagenDefectos1, nombreImagenDefectos2, nombreImagenDefectos3, nombreImagenDefectos4);

end
