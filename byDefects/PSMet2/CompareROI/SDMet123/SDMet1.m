function [ output_args ] = SDMet1(imageNameToSegment, imageNameOutput)
% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
%% segmentation with Sobel filters
IOrig=imread(imageNameToSegment);

IGray=rgb2gray(IOrig);
BW3 = edge(IGray,'canny');
SE = strel('diamond', 1);
BW4 = imclose(BW3,SE);
BW5 = imfill(BW4,'holes');

SE = strel('diamond', 1);
BW6 = imerode(BW5,SE);

BW7=BW6;
%% Store cluster images in files
imwrite(BW7,imageNameOutput,'jpg');


end

