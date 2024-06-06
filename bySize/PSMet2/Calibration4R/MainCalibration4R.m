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
%{
This script generates a file with the initial calibration settings for the software. It allows you to obtain equivalences to convert from pixels to millimeters.
It is based on the assumption of a controlled environment with 4 views. View 1 corresponds to the object in the camera and views 2 to 4 are reflections in 3 mirrors.
We work with an equivalence for the 4 views.

Este script genera un archivo con las configuraciones de calibración iniciales para el software. Permite obtener equivalencias para realizar conversiones de pixeles a milímetros.
Se basa en el supuesto de un mbiente controlado con 4 vistas. La vista 1 se corresponde al objeto en la cámara y las vistas 2 a 4 son los reflejos en 3 espejos.
Se trabaja con una equivalencia para las 4 vistas. 

%}
% Usage:
% MainCalibration4R.m
%

%% Initial parameter setting
clc; clear all; close all;

%% Setting script operating parameters
% IMPORTANT!!! CONFIGURE HERE THE MAIN FOLDER FOR YOUR PROJECT
% HOME=fullfile('C:','Users','Usuari','development','orange_classification'); % for Windows systems
HOME=fullfile('/','home','usuario','development','orange_classification'); % for Linux systems
RESULTS_ROOT=fullfile(HOME,'OrangeResults');
DATASET=fullfile(RESULTS_ROOT,'DATASET');
imageExtension='*.jpg';

%% Setting up the directory folder structure
calibration4RPath=fullfile(RESULTS_ROOT,'bySize','PSMet2','Calibration4R');
pathImagesCalibration=fullfile(DATASET,'inputToCalibrate');
pathImagesSamples=fullfile(DATASET,'inputToCalibrate');

configurationPath=fullfile(calibration4RPath,'conf');
pathCalibration=fullfile(calibration4RPath,'calibration'); %se utiliza para situar las imagenes de calibracion
pathSilohuettesCalibration=fullfile(pathCalibration,'sFrutas');
pathResults=fullfile(calibration4RPath,'output');%se guardan los resultados

imageNameP='calibracion_001.jpg';
fprintf('\n 1) Copy the obtained calibration file to the directory %s \n',pathImagesCalibration);
fprintf('\n 2) Rename the file to %s \n',imageNameP);

% Image name for temporal images used for calibration
imageNameRegion1=fullfile(pathCalibration,strcat(imageNameP,'_','r1.jpg'));
imageNameRegion2=fullfile(pathCalibration,strcat(imageNameP,'_','r2.jpg'));
imageNameRegion3=fullfile(pathCalibration,strcat(imageNameP,'_','r3.jpg'));
imageNameRegion4=fullfile(pathCalibration,strcat(imageNameP,'_','r4.jpg'));


% Silhouettes morphological operations calibration
imageNameSilhouette1=fullfile(pathCalibration,strcat(imageNameP,'_','sN1.jpg'));
imageNameSilhouette2=fullfile(pathCalibration,strcat(imageNameP,'_','sN2.jpg'));
imageNameSilhouette3=fullfile(pathCalibration,strcat(imageNameP,'_','sN3.jpg'));
imageNameSilhouette4=fullfile(pathCalibration,strcat(imageNameP,'_','sN4.jpg'));

%% Configuration filename
configurationFile=fullfile(configurationPath,'20170916configuracion.xml'); % Contains coordinates values used for image processing
execution_time=string(datetime('now','Format','yyyyMMddHHmmss'));
filenameCalibration='20170916calibracion.xml'; % it use an existent file
pathCalibrationFile=fullfile(configurationPath,filenameCalibration);
pathVectorFile=fullfile(pathResults,'archivoCalibracion.csv'); % file with outpus from this module


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

%% User input
%calibrationFlag=input('Enter 0=no calibration, 1=already calibrated >');
TOCALIBRATE=1;
calibrationFlag=0;
%% For removing old files
delete(pathVectorFile);

%% start calibration
if(calibrationFlag==TOCALIBRATE)
    filenameCalibration= strcat(execution_time,'calibracion.xml');
    pathCalibrationFile=fullfile(configurationPath,filenameCalibration);
    fprintf('\n--- Calibrating with images --- \n');
    ProcessCalibrationImg(pathImagesCalibration, pathCalibration, imageNameP, rectangleList, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax);
    calibrationDef24R(pathSilohuettesCalibration, imageNameP,pathCalibrationFile);
    fprintf('\n--- Warning! --- \n');
    fprintf('1) Repeat the process as many times as possible, adjust the values ​​manually to match \n the boxes in the file To calibrate over write MANUALLY with the values ​​obtained as results in the file \n %s \n', configurationFile);
    fprintf('2) To calibrate the correspondence between pixels and millimeters, MANUALLY overwrite with the values ​​obtained as results in the file \n %s \n', pathCalibrationFile);
else
    fprintf('\n--- Calculating test values --- \n');
    %% Reading training folder with images. Iterates over images
    imageList=dir(fullfile(pathImagesSamples,imageExtension));
    listSize=size(imageList);
    imageCount=listSize(1);
    
    %% For removing old files
    delete(pathVectorFile);

    %% bach-shaped reading of the camera directory
    for n=1:imageCount
        fprintf('Extracting features for testing-> %s \n',imageList(n).name);
        imageNameP=imageList(n).name;
        ProcessImage(pathImagesSamples, pathCalibration, imageNameP , pathCalibrationFile, pathVectorFile, rectangleList, objectAreaBR, LchannelMin, LchannelMax, AchannelMin, AchannelMax, BchannelMin, BchannelMax);
    end
    
    %% Printing summary report
    fprintf('---------\n');
    fprintf('Summary report \n');
    fprintf('---------\n');
    fprintf('\n -------------------------------- \n');
    fprintf('A total of %i files were processed \n',imageCount);
    fprintf('An expert should label  %i filas \n',imageCount);
    fprintf('In file %s before running the classifier \n', pathVectorFile);
    fprintf('\n -------------------------------- \n');
    fprintf('\n Check the result vector in the file %s \n', pathVectorFile);

end 
