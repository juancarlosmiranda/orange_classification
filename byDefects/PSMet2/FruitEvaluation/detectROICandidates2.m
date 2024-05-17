function [ ] = detectROICandidates2( pathPrincipal, numROI, imageNameRemoved, imageNameFR, imageNameROI, outputImage,fileVectorDef, imageNameOrig)
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
% From an ROI image of the defects, this script obtains a list in a file, 
% which is related to the defects detected and analyzed by a classifier.
%
% Usage:
%
% detectROICandidates2( outputPath, 1, imageNameRemoved1 ,imageNameBinDefects1, imageNameColourDefectsC1, imageNameColourDetection1,fileVectorDef, imageNameP);
%
labelDetected='CANDIDATO';
HOME=fullfile('C:','Users','Usuari','development','orange_classification');
RESULTS_ROOT=fullfile(HOME,'OrangeResults');
pathTraining=fullfile(RESULTS_ROOT,'byDefects','PSMet2','SegMarkExpExtraction','output'); %

%% Reading the image with background removed
IFR=imread(imageNameFR);
ImROI=imread(imageNameROI);

%% Binarization of the silhouette background removed
threshold=graythresh(IFR);
IFRB1=im2bw(IFR,threshold);

%% ------ open image ------
img = imread(imageNameRemoved);
fh = figure;
imshow(img, 'border', 'tight'); % show your image
hold on;

%% Label connected elements
[objectList Ne]=bwlabel(IFRB1);

%% Calculate properties of image objects
objectProperties= regionprops(objectList);

%% Find pixel areas corresponding to objects
pixelAreaList=find([objectProperties.Area]);

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
fileHandlerTraining=fullfile(pathTraining,filenameTraining); % handle for training set
% data is loaded into a table
tablaDSTraining = readtable(fileHandlerTraining,'Delimiter',',','Format',formatSpec);
% classification labels are loaded
tablaDSTrainingClasificacion=tablaDSTraining(:,EXPERT_LABEL);
% the characteristics that will feed the classifier are loaded, the place
tablaDSTrainingCaracteristicas=tablaDSTraining(:,TRAINING_FEATURE01:TRAINING_FEATURE02);

%pause
%% Converting tables to array cell
% In order to enter the classifier, type conversions are performed
arrayTrainingClasificacion=table2cell(tablaDSTrainingClasificacion);

% Converting tables to array and then array to matrix
arrayTrainingFeatures=table2array(tablaDSTrainingCaracteristicas);

fprintf('Training classifier CANDIDATE REGIONS --> \n');
classifierObj = fitcknn(arrayTrainingFeatures,arrayTrainingClasificacion,'NumNeighbors',numberNeighbors,'Standardize',1);

%% gets coordinates area
objectCounter=0; % object found

% check if objects exist, an empty image may appear
if (size(pixelAreaList,2)==0)
    % if no objects exist sets all characteristic values to zero.
    fprintf('number of objects %i \n', objectCounter);
    meanRGBR=0.0;
    meanRGBG=0.0;
    meanRGBB=0.0;
    stdRGBR=0.0;
    stdRGBG=0.0;
    stdRGBB=0.0;
    avgLABL=0.0;
    avgLABA=0.0;
    avgLABB=0.0;
    stdLABL=0.0;
    stdLABA=0.0;
    stdLABB=0.0;
    meanHSVH=0.0;
    meanHSVS=0.0;
    meanHSVV=0.0;
    stdHSVH=0.0;
    stdHSVS=0.0;
    stdHSVV=0.0;
    sumArea=0;
    perimeter=0.0;
    eccentricity=0.0;
    majorAxis=0.0;
    minorAxis=0.0;
    entropy=0.0;
    inercity=0.0;
    energy=0.0;
    labelDetected='VACIO';
    x=0; 
    y=0;
    w=0;
    h=0;
    rowValues=sprintf('%s, %10i, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10i, %10i, %10i, %s \n', imageNameOrig, numROI, objectCounter, meanRGBR, meanRGBG, meanRGBB, stdRGBR, stdRGBG, stdRGBB, avgLABL, avgLABA, avgLABB, stdLABL, stdLABA, stdLABB, meanHSVH, meanHSVS, meanHSVV, stdHSVH, stdHSVS, stdHSVV, sumArea, perimeter, eccentricity, majorAxis, minorAxis, entropy, inercity, energy, x, y, w, h,labelDetected);
    saveAVDefCalyx2( fileVectorDef, rowValues);
else
%% ------------------------
for n=1:size(pixelAreaList,2)
    objectCounter=objectCounter+1;
    coordinatesToPaint=round(objectProperties(pixelAreaList(n)).BoundingBox);
    %% cropping images
    ISiluetaROI = imcrop(IFRB1,coordinatesToPaint);
    IFondoR = imcrop(ImROI,coordinatesToPaint);
    
    %% features extraction
    % using binarized silhouettes with Otzu
    [ meanRGBR, meanRGBG, meanRGBB, stdRGBR, stdRGBG, stdRGBB ] = extractMeanCImgRGB( IFondoR, ISiluetaROI);
    [ avgLABL, avgLABA, avgLABB, stdLABL, stdLABA, stdLABB ] = extractMeanCImgLAB( IFondoR, ISiluetaROI);
    [ meanHSVH, meanHSVS, meanHSVV, stdHSVH, stdHSVS, stdHSVV ] = extractMeanCImgHSV( IFondoR, ISiluetaROI);
    [ sumArea, perimeter, eccentricity, majorAxis, minorAxis ] = extractDefCarGeoImg(ISiluetaROI);    
    [ entropy, inercity, energy  ] = extractCTextures( IFondoR, ISiluetaROI);
    
    fprintf('In file %s before running the DEFECTS classifier \n', fileVectorDef);
    
    %% ---------------  defect classification -------------------------
    cellRegister = {imageNameOrig, meanRGBR, meanRGBG, meanRGBB, stdRGBR, stdRGBG, stdRGBB, avgLABL, avgLABA, avgLABB, stdLABL, stdLABA, stdLABB, meanHSVH, meanHSVS, meanHSVV, stdHSVH, stdHSVS, stdHSVV, sumArea, perimeter, eccentricity, majorAxis, minorAxis, entropy, inercity, energy, labelDetected};
    tablaDSTest = cell2table(cellRegister(1:end,:));
    tableDSTestCompare=tablaDSTest(:,TEST_FEATURE01:TEST_FEATURE02); % table with features
    arrayTest=table2array(tableDSTestCompare); % converts the values to an array to extract what is necessary   
    objectToCompare = arrayTest(1,1:11) % object to compare

    %% Prediction execution
    fprintf('CLASSIFYING CANDIDATE REGIONS --> \n');
    objectPrediction = predict(classifierObj,objectToCompare);
    fprintf('indiceTest=%i ,cs=>%s|\n', objectCounter, char(objectPrediction(1)));

    %% saving file
    rowValues=sprintf('%s, %10i, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10i, %10i, %10i, %s \n', imageNameOrig, numROI, objectCounter, meanRGBR, meanRGBG, meanRGBB, stdRGBR, stdRGBG, stdRGBB, avgLABL, avgLABA, avgLABB, stdLABL, stdLABA, stdLABB, meanHSVH, meanHSVS, meanHSVV, stdHSVH, stdHSVS, stdHSVV, sumArea, perimeter, eccentricity, majorAxis, minorAxis, entropy, inercity, energy, coordinatesToPaint(1), coordinatesToPaint(2), coordinatesToPaint(3), coordinatesToPaint(4), char(objectPrediction(1)));
    saveAVDefCalyx2( fileVectorDef, rowValues);

    %% ------------- drawing marks ---------------
    % % if the object's classification is equal to CALYX or DEFECT, the object is drawn
    %% selector to mark objects in a windows
    switch char(objectPrediction(1))
        case 'DEFECTOS'
        rectangle('Position',objectProperties(n).BoundingBox,'EdgeColor','g','LineWidth',2)
        text(objectProperties(n).Centroid(:,1), objectProperties(n).Centroid(:,2),int2str(n),'Color','b');
        hold on % objects are added to the main figure
        case 'CALYX'
        rectangle('Position',objectProperties(n).BoundingBox,'EdgeColor','r','LineWidth',2)
        text(objectProperties(n).Centroid(:,1), objectProperties(n).Centroid(:,2),int2str(n),'Color','b');
        hold on % objects are added to the main figure
    end
    
end % fin de ciclo

end% fin if

%% ------ close image ------
frm = getframe( fh ); % get the image+rectangle
imwrite( frm.cdata, outputImage ); % save to file
close( fh );

end