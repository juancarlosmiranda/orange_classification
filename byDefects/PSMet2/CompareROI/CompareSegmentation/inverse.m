function [ ] = inverse(maskName, maskNameFinal)
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
%
% Usage:
% 
%

IExp=imread(maskName);
%% 
nivel=graythresh(IExp);
IBExp=im2bw(IExp,nivel);
final=1-IBExp; %inversa
imwrite(final,maskNameFinal,'jpg');

end