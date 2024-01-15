function [ ] = ProcessMarks(pathImages, pathMasks, outputPath, imageNameP, rectangleList, objectAreaBR, lChannelMin, lChannelMax, aChannelMin, aChannelMax, bChannelMax, bChannelMin )
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
% For each image, the background is separated, segmenting the four regions according to frames defined in the image acquisition.
% Background is removed from the acquired images using thresholds for channels in LAB space. And the following intermediate results (images) are generated:
% * Binary regions of interest of the fruit and its reflections in the mirror.
% * Color images without background.
% * Background silhouettes removed.
% * Extraction of geometric features from binary images.
% * Crops of fruit images from each region of the mirror (1..4).
%
%
% Usage:
%
% ProcessMarks(pathImages, pathImagesTraining, outputPath, imageNameP, rectangleList, objectAreaBR, LchannelMin, LChannelMax, AChannelMin, AChannelMax, BChannelMin, BChannelMax )
%

%% Datos de configuración archivos
colourImage=fullfile(pathImages,imageNameP); % original image to extract colour values
maskImage=fullfile(pathMasks,imageNameP); % image with manually made marks (masks for calyx and defects)

%% DIRECTORIOS DE GUARDADO
outputPathBR=fullfile(outputPath,'IBR'); %imagen inicial, background removal siluetas en 1 imagen
pathAplicacionROI=fullfile(outputPath,'IROI'); %imagen inicial, regiones de interes a color con fondo removido de 1 imagen.
pathAplicacionROIMarca=fullfile(outputPath,'MROI'); %imagen marcada, regiones de interes a color 1 imagen


pathAplicacion2=fullfile(outputPath,'ISFrutas'); %siluetas de frutas 1..4 de imagen inicial
pathAplicacion3=fullfile(outputPath,'IRM'); %imagenes fondo removido 1..4 de imagen inicial
pathAplicacionRemMarca=fullfile(outputPath,'MRM'); %imagenes fondo removido de marcas azules 1..4


%% CONFIGURACIONES DEFECTOS MASCARA Y COLOR
pathAplicacionCALROI=fullfile(outputPath,'ROICalyxC'); % 1 imagen con 4 marcas en magenta
pathAplicacionCALROIBin=fullfile(outputPath,'ROICalyxBin'); % 1 imagen con 4 marcas en binario
pathAplicacionDEFROI=fullfile(outputPath,'ROIDefC'); %1 imagen con 4 marcas en azul
pathAplicacionDEFROIBin=fullfile(outputPath,'ROIDefBin'); % % 1 imagen con 4 marcas en binario

pathCalyxColor=fullfile(outputPath,'MCalyxColor'); %almacenado de calyx en color
pathCalyxBinario=fullfile(outputPath,'MCalyxBin'); %almacenado de calyx en binario

pathDefColor=fullfile(outputPath,'MDefColor'); %almacenado de defectos color
pathDefBinario=fullfile(outputPath,'MDefBin'); %almacenado de defectos binario

% --- NOMBRE DE IMAGENES INTERMEDIAS ---
% con fondo removido
nombreImagenBR=fullfile(outputPathBR,strcat(imageNameP,'_','BR.jpg')); %para indicar silueta del fondo removido
nombreImagenROI=fullfile(pathAplicacionROI,strcat(imageNameP,'_','RO.jpg')); %para indicar el fondo removido y ROI
nombreImagenROIMarca=fullfile(pathAplicacionROIMarca,strcat(imageNameP,'_','MRO.jpg')); %para indicar el fondo removido y ROI

nombreImagenF=fullfile(pathAplicacionROI,strcat(imageNameP,'_','I.jpg')); %previa a la inversa

%prefijo para imagenes de fondo removido y siluetas de fondos removidos en
%deteccion de objetos
nombreImagenSiluetaN=fullfile(pathAplicacion2,strcat(imageNameP,'_','sN'));
nombreImagenRemovida=fullfile(pathAplicacion3,strcat(imageNameP,'_','rm'));
nombreImagenRemovidaMarca=fullfile(pathAplicacionRemMarca,strcat(imageNameP,'_','Mrm'));


%DEFINICION DE NOMBRES DE IMAGENES PARA DEFECTOS SEGMENTADO EN COLOR Y EN
%BINARIO
nombreImagenCALROI=fullfile(pathAplicacionCALROI,strcat(imageNameP,'_','DR.jpg')); %para indicar CALIZ en magenta
nombreImagenCALROIBin=fullfile(pathAplicacionCALROIBin,strcat(imageNameP,'_','DRB.jpg')); %para indicar CALIZ en magenta


nombreImagenDEFROI=fullfile(pathAplicacionDEFROI,strcat(imageNameP,'_','DR.jpg')); %para indicar DEFECTOS EN AZUL
nombreImagenDEFROIBin=fullfile(pathAplicacionDEFROIBin,strcat(imageNameP,'_','DRB.jpg')); %para indicar DEFECTOS EN AZUL



nombreImagenCalColor=fullfile(pathCalyxColor,strcat(imageNameP,'_','DC.jpg')); % imagen numerada de cada ROI 1..4  en color calyx  
nombreImagenCalBin=fullfile(pathCalyxBinario,strcat(imageNameP,'_','CALB')); % imagen numerada de cada ROI 1..4 mascara binaria calyx

nombreImagenDefColor=fullfile(pathDefColor,strcat(imageNameP,'_','DC.jpg')); % imagen numerada de cada ROI 1..4  en color calyx  
nombreImagenDefBin=fullfile(pathDefBinario,strcat(imageNameP,'_','DEFB')); % imagen numerada de cada ROI 1..4 mascara binaria calyx




%% -- BEGIN IMAGE PROCESSING ----------------------------------
%% ----- INICIO Definicion de topes
% Para definicion de rectangulos PREVIAMENTE CONFIGURADOS PARA DETECTAR EL
% NUMERO DE IMAGEN A PARTIR DE UNA IMGEN GENERAL CON ESPEJOS
Cuadro1_lineaGuiaInicialColumna=rectangleList(1,1);
Cuadro1_lineaGuiaInicialFila=rectangleList(1,2);
Cuadro1_espacioColumna=rectangleList(1,3);
Cuadro1_espacioFila=rectangleList(1,4);

fprintf('BR -> Segmentación de fondo --> \n'); %salida una imagen con 4 siluetas
BRemovalLAB(colourImage, nombreImagenBR, nombreImagenF, objectAreaBR, lChannelMin, lChannelMax, aChannelMin, aChannelMax, bChannelMax, bChannelMin,Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila-2, Cuadro1_espacioColumna, Cuadro1_espacioFila);

%% Removiendo fondo
fprintf('BR -> Removiendo fondo, separacion ROI--> \n'); %salida una imagen con 4 objetos
backgroundRemoval4(colourImage, nombreImagenBR, nombreImagenROI);
backgroundRemoval4(maskImage, nombreImagenBR, nombreImagenROIMarca);


%% Calyx segmentado
fprintf('DR -> SEGMENTANDO CALIZ MARCADO POR EXPERTO EN 4 ROI, separacion ROI--> \n'); %salida una imagen con 4 objetos
channel1Min = 216.000;
channel1Max = 255.000;
channel2Min = 0.000;
channel2Max = 132.000;
channel3Min = 201.000;
channel3Max = 255.000;
SegmentDefMarksRGB(maskImage, nombreImagenCALROI, nombreImagenCALROIBin, channel1Min, channel1Max, channel2Min, channel2Max, channel3Min, channel3Max);


%% Defectos segmentados
fprintf('DR -> SEGMENTANDO AREAS DE DEFECTOS MARCADOS POR EXPERTO EN 4 ROI, separacion ROI--> \n'); %salida una imagen con 4 objetos
channel1Min = 0.000;
channel1Max = 15.000;
channel2Min = 0.000;
channel2Max = 11.000;
channel3Min = 231.000;
channel3Max = 255.000;


SegmentDefMarksRGB(maskImage, nombreImagenDEFROI, nombreImagenDEFROIBin, channel1Min, channel1Max, channel2Min, channel2Max, channel3Min, channel3Max);

%% Recortes de ROI
fprintf('BR -> Detección de objetos en cuadros. Recortando ROI y siluetas ROI --> \n'); %salida 4 imagenes de un objeto cada una
%asigna numeros de objetos segun la pertenencia al cuadro
objectDetection2( nombreImagenBR, nombreImagenROI, nombreImagenSiluetaN, nombreImagenRemovida, rectangleList ); 
objectDetection2( nombreImagenBR, nombreImagenROIMarca, nombreImagenSiluetaN, nombreImagenRemovidaMarca, rectangleList ); 


%recorta en base a siluetas caliz
objectDetectionCut( nombreImagenBR, nombreImagenCALROI, nombreImagenCalColor, rectangleList );
objectDetectionCut( nombreImagenBR, nombreImagenCALROIBin, nombreImagenCalBin, rectangleList );

% recorta en base a siluetas defectos
objectDetectionCut( nombreImagenBR, nombreImagenDEFROI, nombreImagenDefColor, rectangleList );
objectDetectionCut( nombreImagenBR, nombreImagenDEFROIBin, nombreImagenDefBin, rectangleList );

%% -- END IMAGE PROCESSING ----------------------------------

end %end ProcesamientoImagen

