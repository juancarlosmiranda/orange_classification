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

  Run this script to create temporal folders and initial settings.

%}
% Usage:
% MainSettings.m
%


%% Initial parameter setting
clc; clear all; close all;
 
%% Defining the directory structure
% HOME=fullfile('C:','Users','Usuari','development','orange_classification'); % for Windows systems
HOME=fullfile('/','home','usuario','development','orange_classification'); % for Linux systems
RESULTS_ROOT=fullfile(HOME,'OrangeResults');
PREPROCESSED_DATASET=fullfile(RESULTS_ROOT,'PREPROCESSED_DATASET');
testImagePath=fullfile(PREPROCESSED_DATASET,'inputTest');
trainingImagePath=fullfile(PREPROCESSED_DATASET,'inputTraining');



% Takes as input images generated in a previous step with MainSegMarkExp.m
% Modules
setCreatorPath=fullfile(HOME,'OrangeResults','byDefects','PSMet2','SetCreator');
segMarkExpPath=fullfile(RESULTS_ROOT,'byDefects','PSMet2','SegMarkExp');
segMarkExpExtractionPath=fullfile(RESULTS_ROOT, 'byDefects','PSMet2','SegMarkExpExtraction');
fruitEvaluationPath=fullfile(RESULTS_ROOT,'byDefects','PSMet2','FruitEvaluation');

% output folders for modules
setCreatorOutputPath=fullfile(setCreatorPath,'output');
segMarkExpOutputPath=fullfile(segMarkExpPath,'tmpToLearn');
segMarkExpExtractionOutputPath=fullfile(segMarkExpExtractionPath,'output');
fruitEvaluationOutputPath=fullfile(fruitEvaluationPath,'tmpToLearn');

imageFormat='.jpg';
imageFilter=strcat('*',imageFormat);

%% dataset hierarchy
%% dataset hierarchy
%
%|__/orange_classification/
%   |__/OrangeResults/
%   |   |__/byDefects/
%   |   |    |__/PSMet2/
%   |   |        |__/SegMarkExp/
%   |   |        |    |__/tmpToLearn/
%   |   |        |       |__/IBR/
%   |   |        |       |__/IROI/
%   |   |        |       |__/MROI/
%   |   |        |       |__/ROICalyxC/
%   |   |        |       |__/ROICalyxBin/
%   |   |        |       |__/ROIDefBin/
%   |   |        |       |__/ISFrutas/
%   |   |        |       |__/IRM/
%   |   |        |       |__/MRM/
%   |   |        |       |__/MDefColor/
%   |   |        |       |__/MCalyxColor/
%   |   |        |       |__/MCalyxBin/
%   |   |        |       |__/MDefBin/
%   |   |        |       |__/cCalyx/
%   |   |        |       |__/cDefectos/
%   |   |        |
%   |   |        |__/SegMarkExpExtraction/
%   |   |        |    |__/output/
%   |   |        |   
%   |   |        |__/FruitEvaluation/
%   |   |        |    |__/conf/
%   |   |        |    |__/output/
%   |   |        |    |__/tmpToLearn/
%   |   |        |       |__/br/
%   |   |        |       |__/roi/
%   |   |        |       |__/sFrutas/
%   |   |        |       |__/removido/
%   |   |        |       |__/sDefectos/
%   |   |        |       |__/contornos/
%   |   |        |       |__/defectos/
%   |   |        |       |__/cDefectos/
%   |   |        |       |__/deteccion/
%   |   |        | 
%   |
%   |
%   |__/DATASET/
%   |      |__/inputToLearn/ -> RGB images
%   |      |__/inputMarked/ -> RGB images with masks
%   |
%   |__/PREPROCESSED_DATASET/
%          |__/inputTest -> folder with images for tests
%          |__/inputTraining -> folder with images for training.
%
%

% MainSetCreator.m - Creating preprocessed dataset
[status,msg] = mkdir(PREPROCESSED_DATASET);
[status,msg] = mkdir(testImagePath);
[status,msg] = mkdir(trainingImagePath);

%
%[status,msg] = mkdir(SegMarkExpExtractionPath);

% SegMarkExp temporal folders
[status,msg] = mkdir(segMarkExpPath);
[status,msg] = mkdir(segMarkExpOutputPath);


[status,msg] = mkdir(segMarkExpExtractionPath);
[status,msg] = mkdir(segMarkExpExtractionOutputPath);



[status,msg] = mkdir(fruitEvaluationPath);
[status,msg] = mkdir(fruitEvaluationOutputPath);


% MainSegMarkExp.m


% organised according to the order of appearance
pathIBR=fullfile(segMarkExpOutputPath,'IBR');
pathIROI=fullfile(segMarkExpOutputPath,'IROI');
pathMROI=fullfile(segMarkExpOutputPath,'MROI');
pathROICalyxC=fullfile(segMarkExpOutputPath,'ROICalyxC');
pathROICalyxBin=fullfile(segMarkExpOutputPath,'ROICalyxBin');
pathROIDefC=fullfile(segMarkExpOutputPath,'ROIDefC');
pathROIDefBin=fullfile(segMarkExpOutputPath,'ROIDefBin');
pathISFrutas=fullfile(segMarkExpOutputPath,'ISFrutas');
pathIRM=fullfile(segMarkExpOutputPath,'IRM');
pathMRM=fullfile(segMarkExpOutputPath,'MRM');
pathMDefColor=fullfile(segMarkExpOutputPath,'MDefColor');
pathMCalyxColor=fullfile(segMarkExpOutputPath,'MCalyxColor');
pathBinaryCalyx=fullfile(segMarkExpOutputPath,'MCalyxBin'); % binary calyx masks with background removed in regions 1..4
pathDefBinary=fullfile(segMarkExpOutputPath,'MDefBin'); % binary defects masks with background removed in regions 1..4
pathColourCalyx=fullfile(segMarkExpOutputPath,'cCalyx'); % to keep the calyx in colour
pathcDefectos=fullfile(segMarkExpOutputPath,'cDefectos'); %defectos en color

% MainSegMarkExp.m - organised according to the order of appearance
[status,msg] = mkdir(pathIBR);
[status,msg] = mkdir(pathIROI);
[status,msg] = mkdir(pathMROI);
[status,msg] = mkdir(pathROICalyxC);
[status,msg] = mkdir(pathROICalyxBin);
[status,msg] = mkdir(pathROIDefC);
[status,msg] = mkdir(pathROIDefBin);
[status,msg] = mkdir(pathISFrutas);
[status,msg] = mkdir(pathIRM);
[status,msg] = mkdir(pathMRM);
[status,msg] = mkdir(pathMCalyxColor);
[status,msg] = mkdir(pathMDefColor);
[status,msg] = mkdir(pathBinaryCalyx);
[status,msg] = mkdir(pathDefBinary);
[status,msg] = mkdir(pathColourCalyx);
[status,msg] = mkdir(pathcDefectos);


% MainDefDetectONLINE4r.m
pathbr=fullfile(fruitEvaluationOutputPath,'br');
pathroi=fullfile(fruitEvaluationOutputPath,'roi');
pathsFrutas=fullfile(fruitEvaluationOutputPath,'sFrutas');
pathremovido=fullfile(fruitEvaluationOutputPath,'removido');
pathsDefectos=fullfile(fruitEvaluationOutputPath,'sDefectos');
pathcontornos=fullfile(fruitEvaluationOutputPath,'contornos');
pathdefectos=fullfile(fruitEvaluationOutputPath,'defectos');
pathcDefectos=fullfile(fruitEvaluationOutputPath,'cDefectos');
pathdeteccion=fullfile(fruitEvaluationOutputPath,'deteccion');

[status,msg] = mkdir(pathbr);
[status, msg] = mkdir(pathroi);
[status,msg] = mkdir(pathsFrutas);
[status,msg] = mkdir(pathremovido);
[status,msg] = mkdir(pathsDefectos);
[status,msg] = mkdir(pathcontornos);
[status,msg] = mkdir(pathdefectos);
[status,msg] = mkdir(pathcDefectos);
[status,msg] = mkdir(pathdeteccion);


%% Printing summary report
fprintf('---------\n');
fprintf('Summary report \n');
fprintf('---------\n');