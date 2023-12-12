function [ ] = copyDirectory( tablaDSTArchivos, pathEntradaImagenesFuente, pathEntradaImagenesDestino)
% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
tamanoTablaArchivos=size(tablaDSTArchivos);
TotalFilas=tamanoTablaArchivos(1);

for(contadorRandom=1:1:TotalFilas)
    %% copiando desde imagenes originales a test
    archivoCopiarFuente=fullfile(pathEntradaImagenesFuente,tablaDSTArchivos(contadorRandom).name);
    archivoCopiarDestino=fullfile(pathEntradaImagenesDestino,tablaDSTArchivos(contadorRandom).name);
    
    %% comando de copia
    fprintf("COPYING FILES %s %s \n",archivoCopiarFuente, archivoCopiarDestino);
    [status,msg] = copyfile(archivoCopiarFuente,archivoCopiarDestino);
    
    % 12/12/2023 deprecated because it is Linux oriented command line
    % supplanted by MATLAB command for file operations
    %comando = { 'cp','-f',archivoCopiarFuente, archivoCopiarDestino};
    %command=strjoin(comando)
    %[status,cmdout] = system(command);    

end % (contadorRandom=1:1:TotalFilas)




end

