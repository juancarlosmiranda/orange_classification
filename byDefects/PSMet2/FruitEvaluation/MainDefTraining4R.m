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
% This script receives numerical features from a file and trains a classifier.
% Produces a file with a trained model, ready to use.
% The file is produced by "/orange_classification/OrangeResults/byDefects/PSMet2/SegMarkExpExtraction/output/BDDEFECTOSCALYX.csv"
%
%
% Usage:
% MainDefTraining4R.m
%
%

%% Initial parameter setting
clc; clear all; close all;
 
%% Setting script operating parameters
% HOME=fullfile('C:','Users','Usuari','development','orange_classification'); % for Windows systems
HOME=fullfile('/','home','usuario','development','orange_classification'); % for Linux systems
RESULTS_ROOT=fullfile(HOME,'OrangeResults');
fruitEvaluationPath=fullfile(RESULTS_ROOT,'byDefects','PSMet2','FruitEvaluation');
configurationPath=fullfile(fruitEvaluationPath,'conf');
fruitEvaluationOutputPath=fullfile(fruitEvaluationPath,'tmpToLearn'); % temporal folder

%% Classifier path
%% ---------------------
%% FEATURES
%% Carga del dataset de entrenamiento
EXPERT_LABEL=34;
TRAINING_FEATURE01=16;
TRAINING_FEATURE02=26;

% They do not have the same address because the test file is built with
% each defect
TEST_FEATURE01=14;
TEST_FEATURE02=24;

numberNeighbors=5;
formatSpec='%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s';

filenameTraining='BDDEFECTOSCALYX.csv';
fileHandlerTraining=fullfile(configurationPath,filenameTraining); % handle for training set
% data is loaded into a table
tableDSTraining = readtable(fileHandlerTraining,'Delimiter',',','Format',formatSpec);
% classification labels are loaded
tableDSTrainingClasificacion=tableDSTraining(:,EXPERT_LABEL);
% the characteristics that will feed the classifier are loaded, the place
tableDSTrainingFeatures=tableDSTraining(:,TRAINING_FEATURE01:TRAINING_FEATURE02);

%pause
%% Converting tables to array cell
% In order to enter the classifier, type conversions are performed
arrayTrainingClassification=table2cell(tableDSTrainingClasificacion);

% Converting tables to array and then array to matrix
arrayTrainingFeatures=table2array(tableDSTrainingFeatures);

fprintf('Training classifier CANDIDATE REGIONS --> \n');
% 25/05/2024 to refactor, load trained classifier from a file
classifierObj = fitcknn(arrayTrainingFeatures,arrayTrainingClassification,'NumNeighbors',numberNeighbors,'Standardize',1);

%% Saving trained model
filenameModel='MY_TRAINED_MODEL.mat';
fileHandlerModelPath=fullfile(configurationPath,filenameModel);
saveLearnerForCoder(classifierObj,fileHandlerModelPath);

%% ---------------------

%% Printing summary report
fprintf('---------\n');
fprintf('Summary report \n');
fprintf('---------\n');
fprintf('\n -------------------------------- \n');
%fprintf('A total of %i files were processed \n',imageCount);
fprintf('Filename model %s \n', filenameModel);
fprintf('The parameters of the trained classifier can be accessed at %s \n', fileHandlerModelPath);
fprintf('\n -------------------------------- \n');
