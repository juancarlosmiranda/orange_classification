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
% Data obtained after applying a segmentation method is generated and a
% pre-trained defect classifier. In the end you get a list with the 
% classifications of what was detected.
%
% Se generan datos obtenidos luego de aplicar un método de segmentación y
% un clasificador de defectos previamente entrenado. Al final se obtiene un
% listado con las clasificaciones de lo detectado.
%
% Usage:
% MainDefSDMet1.m
%
%
%% Initial parameter setting
clc; clear all; close all;
 
%% Setting script operating parameters
HOME=fullfile('C:','Users','Usuari','development','orange_classification');
mainPath=fullfile(HOME,'OrangeResults','byDefects','PSMet2','CompareROI'); %
pathImages=fullfile(HOME,'OrangeResults','inputToLearn');
configurationPath=fullfile(mainPath,'conf');
pathAplicacion=fullfile(mainPath,'tmpToLearn','SDMet1'); % TODO VERIFICAR
pathAplicacionSiluetas=fullfile(pathAplicacion,'sFrutas'); % TODO VERIFICAR
outputPath=fullfile(mainPath,'output');
imageExtension='*.jpg';

 %% Nombres de archivos de configuracion
 % trabajan con métodos para equivalencia con las 4 vistas

%%
configurationFile=fullfile(configurationPath,'20170916configuracion.xml'); % for initial coordinates in image processing
calibrationFile=fullfile(configurationPath,'20170916calibracion.xml'); % to indicate to the user in the final part of the calibration
  
%% Definition of rectangles according to numbering
row01=readConfiguration('Fila1', configurationFile);
bottomRow=readConfiguration('FilaAbajo', configurationFile);

% Rectangle 1 downside
rectangle1_Y=readConfiguration('Cuadro1_lineaGuiaInicialFila', configurationFile);
rectangle1_X=readConfiguration('Cuadro1_lineaGuiaInicialColumna', configurationFile);
rectangle1_H=readConfiguration('Cuadro1_espacioFila', configurationFile);
rectangle1_W=readConfiguration('Cuadro1_espacioColumna', configurationFile);

% Rectangle 2 left side
rectangle2_Y=readConfiguration('Cuadro2_lineaGuiaInicialFila', configurationFile);
rectangle2_X=readConfiguration('Cuadro2_lineaGuiaInicialColumna', configurationFile);
rectangle2_H=readConfiguration('Cuadro2_espacioFila', configurationFile);
rectangle2_W=readConfiguration('Cuadro2_espacioColumna', configurationFile);

% Rectangle 3 center
rectangle3_Y=readConfiguration('Cuadro3_lineaGuiaInicialFila', configurationFile);
rectangle3_X=readConfiguration('Cuadro3_lineaGuiaInicialColumna', configurationFile);
rectangle3_H=readConfiguration('Cuadro3_espacioFila', configurationFile);
rectangle3_W=readConfiguration('Cuadro3_espacioColumna', configurationFile);

% Rectangle 4 right side
rectangle4_Y=readConfiguration('Cuadro4_lineaGuiaInicialFila', configurationFile);
rectangle4_X=readConfiguration('Cuadro4_lineaGuiaInicialColumna', configurationFile);
rectangle4_H=readConfiguration('Cuadro4_espacioFila', configurationFile);
rectangle4_W=readConfiguration('Cuadro4_espacioColumna', configurationFile);

%% Loading rectangles into memory to be fast
% Definition of a rectangle region
%[X,Y,W,H] top-left corner X,Y; W=horizontal width, H= vertical height
% * ---------> X
% |  (x,y)-----|
% |  |         |
% |  |------ W,H
% |
% Y
% V

rectangleList=[rectangle1_X, rectangle1_Y, rectangle1_W, rectangle1_H;
rectangle2_X, rectangle2_Y, rectangle2_W, rectangle2_H;
rectangle3_X, rectangle3_Y, rectangle3_W, rectangle3_H;
rectangle4_X, rectangle4_Y, rectangle4_W, rectangle4_H;
0,0,0,0
];

%% Image processing settings
objectAreaBR=5000; % Area value to filter silhouettes and object detection (granulometry).
% Setting thresholds for LAB colour space values, % background thresholding
% parameters
LchannelMin = 0.0; LchannelMax = 96.653; AchannelMin = -23.548; AchannelMax = 16.303; BchannelMin = -28.235; BchannelMax = -1.169;

%% CONFIGURACIONES PARA DETECCION DE DEFECTOS
sizeContours=1000; % is used for contour extraction. The contours are above 1000 pixels
candidateFile=fullfile(outputPath,'aCandidatos.csv'); % output file defect candidates

% Temporal data folder hierarchy
% 
%|__/HOME/DATASET/
%   |__/sFrutas
%   |__/ROIDefC
%   |__/ROIDefBin
%   |__/ROICalyxC
%   |__/ROICalyxBin
%   |__/MROI
%   |__/MRM
%   |__/MDefColor
%   |__/MDefBin
%   |__/MCalyxColor
%   |__/MCalyxBin
%   |__/ISFrutas
%   |__/IROI
%   |__/IRM
%   |__/IBR
%   |__/cDefectos
%   |__/cCalyx
%

%% Cleaning temporal files
% TODO: Create a script for definition of a folder hierarchy
% tmpToLearn/
fprintf('Cleaning old images \n');
delete(candidateFile);
delete(fullfile(outputPath,'sFrutas',imageExtension));
delete(fullfile(outputPath,'sDefectos',imageExtension));
delete(fullfile(outputPath,'roi',imageExtension));
delete(fullfile(outputPath,'removido',imageExtension));
delete(fullfile(outputPath,'deteccion',imageExtension));
delete(fullfile(outputPath,'defectos',imageExtension));
delete(fullfile(outputPath,'contornos',imageExtension));
delete(fullfile(outputPath,'cDefectos',imageExtension));
delete(fullfile(outputPath,'br',imageExtension));

%% --------------------------------------------------------------------
%% Reading training folder with images. Iterates over images
imageList=dir(fullfile(pathImages,imageExtension));
imageNameP='nombreImagenP';
listSize=size(imageList);
imageCount=listSize(1);
%% bach-shaped reading of the camera directory
for n=1:imageCount
    fprintf('Extrayendo características para entrenamiento-> %s \n',imageList(n).name);    
    imageNameP=imageList(n).name;
    ProcessImgSoft(pathImages, pathAplicacion, imageNameP, rectangleList, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax );
    ExtractDefDetectImgSoftSDMet1(pathImages, pathAplicacion, imageNameP, candidateFile, sizeContours)
    %if n==1
    %    break;
    %end %if n==11
end %


%% Printing summary report
fprintf('---------\n');
fprintf('Summary report \n');
fprintf('---------\n');
fprintf('\n -------------------------------- \n');
fprintf('A total of %i files were processed \n',imageCount);
fprintf('Check analysis results in %s \n', candidateFile)
fprintf('\n -------------------------------- \n');
