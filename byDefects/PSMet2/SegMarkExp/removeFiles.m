function [ output_args ] = removeFiles( archivoBorrar)
% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
fprintf("--> %s \n",archivoBorrar);
delete(archivoBorrar);
% 12/12/2023 changed by MATLAB commands for file operations
% comando = { 'rm','-rf',archivoBorrar};
%command=strjoin(comando);/
%[status,cmdout] = system(command);
end

