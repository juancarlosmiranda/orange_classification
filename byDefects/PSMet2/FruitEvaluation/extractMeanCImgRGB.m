function [ meanR, meanG, meanB, stdDevR, stdDevG, stdDevB ] = extractMeanCImgRGB( IRGBCropped, IMaskC)
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
% This function calculates the average colour of an image, using a mask to 
% quantify the colour and values that are extracted.
% The result is obtained converting images to the RGB color space.
%

% Usage:
% [ meanRGBR, meanRGBG, meanRGBB, stdRGBR, stdRGBG, stdRGBB ] = extractMeanCImgRGB( IBackgroundR, IShapeROI);
%
% Foreground values are 1, background values are 0
FOREGROUND=1;

% Reading background image
IMask=IMaskC;

[rowSize, colSize, ~]=size(IRGBCropped);

sumR=double(0.0);
sumG=double(0.0);
sumB=double(0.0);
pixelCounter=double(0.0);

% variables for calculating variance
varianceSumR=double(0.0);
varianceSumG=double(0.0);
varianceSumB=double(0.0);

% iterating over the mask
for f=1:1:rowSize
    for c=1:1:colSize
        % Read from the mask image if the value is different from zero
        pixelMask=IMask(f,c);
        if pixelMask == FOREGROUND
            sumR=double(IRGBCropped(f,c,1))+sumR;
            sumG=double(IRGBCropped(f,c,2))+sumG;
            sumB=double(IRGBCropped(f,c,3))+sumB; 
            pixelCounter=pixelCounter+1;
        end
    end
end

% --------------------------------------
% mean values calculated by channels
%---------------------------------------
meanR=double(sumR/pixelCounter); % mean R channel
meanG=double(sumG/pixelCounter); % mean G channel
meanB=double(sumB/pixelCounter); % mean B channel

%------------------------------------------------------------------------
% sample variance
%------------------------------------------------------------------------
for f=1:1:rowSize
    for c=1:1:colSize
        % Read from the mask image, and checking if the value is different from zero.
        pixelMask=IMask(f,c);
        if pixelMask == FOREGROUND            
            varianceSumR=varianceSumR+(IRGBCropped(f,c,1)-meanR)^2;
            varianceSumG=varianceSumG+(IRGBCropped(f,c,2)-meanG)^2;
            varianceSumB=varianceSumB+(IRGBCropped(f,c,3)-meanB)^2;            
        end
    end
end
% -----------------------------------------------------------------------

stdDevR=sqrt(double(varianceSumR/(pixelCounter)));
stdDevG=sqrt(double(varianceSumG/(pixelCounter)));
stdDevB=sqrt(double(varianceSumB/(pixelCounter)));

end


