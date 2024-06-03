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

%% MainSetCreator.m - Creating preprocessed dataset
[status,msg] = mkdir(PREPROCESSED_DATASET);
[status,msg] = mkdir(testImagePath);
[status,msg] = mkdir(trainingImagePath);

% SegMarkExp temporal folders
[status,msg] = mkdir(segMarkExpPath);
[status,msg] = mkdir(segMarkExpOutputPath);

[status,msg] = mkdir(segMarkExpExtractionPath);
[status,msg] = mkdir(segMarkExpExtractionOutputPath);



[status,msg] = mkdir(fruitEvaluationPath);
[status,msg] = mkdir(fruitEvaluationOutputPath);


%% MainSegMarkExp.m - organised according to the order of appearance
% path definition
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

% path creation
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


%% MainDefDetectONLINE4r.m
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

%% Comparison between methods
compareROIPath=fullfile(RESULTS_ROOT,'byDefects','PSMet2','CompareROI');
SDMet1Path=fullfile(compareROIPath,'tmpToLearn','SDMet1');
SDMet2Path=fullfile(compareROIPath,'tmpToLearn','SDMet2');
SDMet3Path=fullfile(compareROIPath,'tmpToLearn','SDMet3');

% MainDefSDMet1.m
SDMet1pathbr=fullfile(SDMet1Path,'br');
SDMet1pathroi=fullfile(SDMet1Path,'roi');
SDMet1pathsFrutas=fullfile(SDMet1Path,'sFrutas');
SDMet1pathremovido=fullfile(SDMet1Path,'removido');
SDMet1pathsDefectos=fullfile(SDMet1Path,'sDefectos');
SDMet1pathdefectos=fullfile(SDMet1Path,'defectos');
SDMet1pathcDefectos=fullfile(SDMet1Path,'cDefectos');

[status,msg] = mkdir(SDMet1pathbr);
[status, msg] = mkdir(SDMet1pathroi);
[status,msg] = mkdir(SDMet1pathsFrutas);
[status,msg] = mkdir(SDMet1pathremovido);
[status,msg] = mkdir(SDMet1pathsDefectos);
[status,msg] = mkdir(SDMet1pathdefectos);
[status,msg] = mkdir(SDMet1pathcDefectos);


% MainDefSDMet2.m - Comparison between methods
SDMet2pathbr=fullfile(SDMet2Path,'br');
SDMet2pathroi=fullfile(SDMet2Path,'roi');
SDMet2pathsFrutas=fullfile(SDMet2Path,'sFrutas');
SDMet2pathremovido=fullfile(SDMet2Path,'removido');
SDMet2pathsDefectos=fullfile(SDMet2Path,'sDefectos');
SDMet2pathcontornos=fullfile(SDMet2Path,'contornos');
SDMet2pathdefectos=fullfile(SDMet2Path,'defectos');
SDMet2pathcDefectos=fullfile(SDMet2Path,'cDefectos');

[status,msg] = mkdir(SDMet2pathbr);
[status, msg] = mkdir(SDMet2pathroi);
[status,msg] = mkdir(SDMet2pathsFrutas);
[status,msg] = mkdir(SDMet2pathremovido);
[status,msg] = mkdir(SDMet2pathsDefectos);
[status,msg] = mkdir(SDMet2pathcontornos);
[status,msg] = mkdir(SDMet2pathdefectos);
[status,msg] = mkdir(SDMet2pathcDefectos);
%[status,msg] = mkdir(SDMet2pathdeteccion);


% MainDefSDMet3.m - Comparison between methods
SDMet3pathbr=fullfile(SDMet3Path,'br');
SDMet3pathroi=fullfile(SDMet3Path,'roi');
SDMet3pathsFrutas=fullfile(SDMet3Path,'sFrutas');
SDMet3pathremovido=fullfile(SDMet3Path,'removido');
SDMet3pathsDefectos=fullfile(SDMet3Path,'sDefectos');
SDMet3pathcontornos=fullfile(SDMet3Path,'contornos');
SDMet3pathdefectos=fullfile(SDMet3Path,'defectos');
SDMet3pathcDefectos=fullfile(SDMet3Path,'cDefectos');

[status,msg] = mkdir(SDMet3pathbr);
[status, msg] = mkdir(SDMet3pathroi);
[status,msg] = mkdir(SDMet3pathsFrutas);
[status,msg] = mkdir(SDMet3pathremovido);
[status,msg] = mkdir(SDMet3pathsDefectos);
[status,msg] = mkdir(SDMet3pathcontornos);
[status,msg] = mkdir(SDMet3pathdefectos);
[status,msg] = mkdir(SDMet3pathcDefectos);

%% Compare segmentation
CompareSDMet1Path=fullfile(compareROIPath,'tmpToLearn','CompareSDMet1');
CompareSDMet2Path=fullfile(compareROIPath,'tmpToLearn','CompareSDMet2');
CompareSDMet3Path=fullfile(compareROIPath,'tmpToLearn','CompareSDMet3');

[status,msg] = mkdir(CompareSDMet1Path);
[status,msg] = mkdir(CompareSDMet2Path);
[status,msg] = mkdir(CompareSDMet3Path);


% MainMet4RSDMet1
SDMet1PathBinaryExp=fullfile(CompareSDMet1Path,'ExpertoBin');
SDMet1PathFPFNBin=fullfile(CompareSDMet1Path,'FPFNBin');
SDMet1PathTPTNBin=fullfile(CompareSDMet1Path,'TPTNBin');
SDMet1PathFNBin=fullfile(CompareSDMet1Path,'FNBin');
SDMet1PathFPBin=fullfile(CompareSDMet1Path,'FPBin');
SDMet1PathTPBin=fullfile(CompareSDMet1Path,'TPBin');
SDMet1PathTNBin=fullfile(CompareSDMet1Path,'TNBin');
SDMet1PathTPFPFNBin=fullfile(CompareSDMet1Path,'TPFPFNBin');

[status,msg] = mkdir(SDMet1PathBinaryExp);
[status,msg] = mkdir(SDMet1PathFPFNBin);
[status,msg] = mkdir(SDMet1PathTPTNBin);
[status,msg] = mkdir(SDMet1PathFNBin);
[status,msg] = mkdir(SDMet1PathFPBin);
[status,msg] = mkdir(SDMet1PathTPBin);
[status,msg] = mkdir(SDMet1PathTNBin);
[status,msg] = mkdir(SDMet1PathTPFPFNBin);

% MainMet4RSDMet2
SDMet2PathBinaryExp=fullfile(CompareSDMet2Path,'ExpertoBin');
SDMet2PathFPFNBin=fullfile(CompareSDMet2Path,'FPFNBin');
SDMet2PathTPTNBin=fullfile(CompareSDMet2Path,'TPTNBin');
SDMet2PathFNBin=fullfile(CompareSDMet2Path,'FNBin');
SDMet2PathFPBin=fullfile(CompareSDMet2Path,'FPBin');
SDMet2PathTPBin=fullfile(CompareSDMet2Path,'TPBin');
SDMet2PathTNBin=fullfile(CompareSDMet2Path,'TNBin');
SDMet2PathTPFPFNBin=fullfile(CompareSDMet2Path,'TPFPFNBin');

[status,msg] = mkdir(SDMet2PathBinaryExp);
[status,msg] = mkdir(SDMet2PathFPFNBin);
[status,msg] = mkdir(SDMet2PathTPTNBin);
[status,msg] = mkdir(SDMet2PathFNBin);
[status,msg] = mkdir(SDMet2PathFPBin);
[status,msg] = mkdir(SDMet2PathTPBin);
[status,msg] = mkdir(SDMet2PathTNBin);
[status,msg] = mkdir(SDMet2PathTPFPFNBin);

% MainMet4RSDMet3
SDMet3PathBinaryExp=fullfile(CompareSDMet3Path,'ExpertoBin');
SDMet3PathFPFNBin=fullfile(CompareSDMet3Path,'FPFNBin');
SDMet3PathTPTNBin=fullfile(CompareSDMet3Path,'TPTNBin');
SDMet3PathFNBin=fullfile(CompareSDMet3Path,'FNBin');
SDMet3PathFPBin=fullfile(CompareSDMet3Path,'FPBin');
SDMet3PathTPBin=fullfile(CompareSDMet3Path,'TPBin');
SDMet3PathTNBin=fullfile(CompareSDMet3Path,'TNBin');
SDMet3PathTPFPFNBin=fullfile(CompareSDMet3Path,'TPFPFNBin');

[status,msg] = mkdir(SDMet3PathBinaryExp);
[status,msg] = mkdir(SDMet3PathFPFNBin);
[status,msg] = mkdir(SDMet3PathTPTNBin);
[status,msg] = mkdir(SDMet3PathFNBin);
[status,msg] = mkdir(SDMet3PathFPBin);
[status,msg] = mkdir(SDMet3PathTPBin);
[status,msg] = mkdir(SDMet3PathTNBin);
[status,msg] = mkdir(SDMet3PathTPFPFNBin);


%% Printing summary report
fprintf('---------\n');
fprintf('Temporal folders created report \n');
fprintf('---------\n');