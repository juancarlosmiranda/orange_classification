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
% Generates images of regions previously marked by HAND
% It is a process prior to automated feature extraction.
% It is assumed that an expert marked the fruits by hand with colors.
% Images are produced as output.
%
% Usage:
% MainMet4RSDMet3.m
%
%
%% Initial parameter setting
clc; clear all; close all;
 
%% Setting script operating parameters
HOME=fullfile('C:','Users','Usuari','development','orange_classification');
RESULTS_ROOT=fullfile(HOME,'OrangeResults');
mainPath=fullfile(RESULTS_ROOT,'byDefects','PSMet2','CompareROI');

% images from original dataset
DATASET=fullfile(RESULTS_ROOT,'DATASET');
pathImages=fullfile(DATASET,'inputToLearn');
pathMarkedColorImages=fullfile(DATASET,'inputMarked');


configurationPath=fullfile(mainPath,'conf');
pathImagesToCompare=fullfile(mainPath,'tmpToLearn','CompareSDMet1');
pathTestedMethod=fullfile(mainPath,'tmpToLearn','SDMet1');
pathPreMarkedImages=fullfile(mainPath,'tmpToLearn','MARKED');
imageExtension='*.jpg';
pathBinaryDef=fullfile(pathPreMarkedImages,'MDefBin');
pathBinaryCalyx=fullfile(pathPreMarkedImages,'MCalyxBin');
pathBinaryExp=fullfile(pathImagesToCompare,'ExpertoBin');
pathBinaryDefects=fullfile(pathTestedMethod,'defectos');

% Settings for comparisons
pathFPFNBin=fullfile(pathImagesToCompare,'FPFNBin');
pathTPTNBin=fullfile(pathImagesToCompare,'TPTNBin');
pathFNBin=fullfile(pathImagesToCompare,'FNBin');
pathFPBin=fullfile(pathImagesToCompare,'FPBin');
pathTPBin=fullfile(pathImagesToCompare,'TPBin');
pathTNBin=fullfile(pathImagesToCompare,'TNBin');
pathTPFPFNBin=fullfile(pathImagesToCompare,'TPFPFNBin');

% Setting the average variables to zero
precisionSummation=0.0;
accuracySummation=0.0;
sensitivitySummation=0.0;
specificitySummation=0.0;

avgPrecision=0.0;
avgAccuracy=0.0;
avgSensitivity=0.0;
avgEspecificity=0.0;

%% Reading training folder with images. Iterates over images
imageList=dir(fullfile(pathMarkedColorImages,imageExtension));
imageNameP='nombreImagenP';
listSize=size(imageList);
imageCount=listSize(1);

%% Calulating pixels applying opoerator over images
for n=1:size(imageList)
    imageNameP=imageList(n).name;
    % it is assumed that there are always 4 images
    for ROI=1:4
        imageNameBinDefects=fullfile(pathBinaryDef,strcat(imageNameP,'_','DEFB', int2str(ROI),'.jpg'));
        imageNameBinCalyx=fullfile(pathBinaryCalyx,strcat(imageNameP,'_','CALB', int2str(ROI),'.jpg'));
        imageNameBinMaskExpert=fullfile(pathBinaryExp,strcat(imageNameP,'_','E', int2str(ROI),'.jpg'));

        % method to test and obtain metrics
        imageNameSoftware=fullfile(pathBinaryDefects,strcat(imageNameP,'_','soM', int2str(ROI),'.jpg'));       
        maskNameTPTN=fullfile(pathTPTNBin,strcat(imageNameP,'_','TPTN', int2str(ROI),'.jpg'));
        maskNameFPFN=fullfile(pathFPFNBin,strcat(imageNameP,'_','FPFN', int2str(ROI),'.jpg'));
        maskNameFN=fullfile(pathFNBin,strcat(imageNameP,'_','FN', int2str(ROI),'.jpg'));
        maskNameFP=fullfile(pathFPBin,strcat(imageNameP,'_','FP', int2str(ROI),'.jpg'));
        maskNameTP=fullfile(pathTPBin,strcat(imageNameP,'_','TP', int2str(ROI),'.jpg'));        
        maskNameTN=fullfile(pathTNBin,strcat(imageNameP,'_','TN', int2str(ROI),'.jpg'));        
        maskNameTPFPFN=fullfile(pathTPFPFNBin,strcat(imageNameP,'_','TO', int2str(ROI),'.jpg'));        
        
        % Merging binary masks
        fprintf('Merging regions marked by an expert -> %s R=%i\n',imageList(n).name,ROI);    
        merged(imageNameBinCalyx,imageNameBinDefects, imageNameBinMaskExpert);
        % Extracting differences FALSE POSITIVES (FP) and FALSE NEGATIVES (FN)
        fprintf('FN and FP -> Expert differences vs. software differences-> %s R=%i \n',imageList(n).name, ROI);        
        difference(imageNameBinMaskExpert, imageNameSoftware, maskNameFPFN);
        % Extracting FN
        fprintf('Looking for FN -> Expert vs FPFN %s R=%i \n',imageList(n).name, ROI);
        coincidence(imageNameBinMaskExpert, maskNameFPFN, maskNameFN);
        % Extracting FP
        fprintf('Looking for FP -> Software vs FPFN %s R=%i \n',imageList(n).name, ROI);        
        coincidence(imageNameSoftware, maskNameFPFN, maskNameFP);
        % Extracting TPTN TRUE POSITIVE (TP) TRUE NEGATIVE (TN)
        fprintf('Looking TP -> Expert vs Software %s R=%i \n',imageList(n).name, ROI);
        coincidence(imageNameBinMaskExpert, imageNameSoftware, maskNameTP);
        fprintf('TN NOT EXPERT + SOFTWARE -> %s R=%i \n',imageList(n).name, ROI);  
        merged(imageNameBinMaskExpert,imageNameSoftware, maskNameTPFPFN);
        % does the inverse to count the TN in pixels
        inverse(maskNameTPFPFN, maskNameTN);

        %% CALCULAR TASA DE DIFERENCIAS Y COINCIDENCIAS
        %% Definicion de variables a cero
        TP=0;
        TN=0;  
        FP=0;
        FN=0;
        
        precision=0.0;
        accuracy=0.0;
        sensitivity=0.0;
        specificity=0.0;
        
        %% counting pixels
        TP=pixelCount(maskNameTP);    
        FP=pixelCount(maskNameFP);
        FN=pixelCount(maskNameFN);
        TN=pixelCount(maskNameTN);
    
        %precision, exactitud, sensibilidad, especificidad
        if((TP+FP)==0)
            precision=0;
        else
            precision=TP/(TP+FP);            
        end
        
        if((TP+FP+TN+FN)==0)
            accuracy=0;
        else
            accuracy=(TP+TN)/(TP+FP+TN+FN);
        end

        if((TP+FN)==0)
            sensitivity=0;
        else
            sensitivity=TP/(TP+FN);
        end

        if((TN+FP)==0)
            specificity=0;
        else
            specificity=TN/(TN+FP);
        end
        
        %% summations
        precisionSummation=precisionSummation+precision;
        accuracySummation=accuracySummation+accuracy;
        sensitivitySummation=sensitivitySummation+sensitivity;
        specificitySummation=specificitySummation+specificity;
        
        fprintf('imagen=%s, ROI=%i -> precision=%f, accuracy=%f,sensitivity=%f specificity=%f\n', imageNameP, ROI, precision, accuracy, sensitivity, specificity);
        
    end
    
    %if n==1
    %    break;
    %end;
end %
totalNumberOfTests=n*4;
       
%% Average caclculation
avgPrecision=precisionSummation/totalNumberOfTests;
avgAccuracy=accuracySummation/totalNumberOfTests;    
avgSensitivity=sensitivitySummation/totalNumberOfTests;
avgEspecificity=specificitySummation/totalNumberOfTests;

fprintf('--------------------------------\n');
fprintf('Summary report, average in %i tests\n', totalNumberOfTests);
fprintf('--------------------------------\n');    
fprintf('precisionSummation=%f, accuracySummation=%f, sensitivitySummation=%f specificitySummation=%f\n', precisionSummation, accuracySummation, sensitivitySummation, specificitySummation);
fprintf('avgPrecision=%f, avgAccuracy=%f, avgSensitivity=%f avgEspecificity=%f\n', avgPrecision, avgAccuracy, avgSensitivity, avgEspecificity);
