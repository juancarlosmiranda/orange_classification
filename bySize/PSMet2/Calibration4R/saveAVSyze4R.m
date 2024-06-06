function [ output_args ] = saveAVSyze4R( filename, rowToAdd )

fileIDTest = fopen(filename,'r'); %el hander para saber si existe
fileID = fopen(filename,'a'); %abre el archivo para agregar datos


if (fileIDTest==-1)
    %% It is a first time
    filaCabecera=sprintf('nombre_imagen, equivPxmmR1, equivPxmmR2, equivPxmmR3, equivPxmmR4, sumaAreaPxR1, sumaAreaPxR2, sumaAreaPxR3, sumaAreaPxR4, diametroPxR1, diametroPxR2, diametroPxR3, diametroPxR4, ejeMayorPxR1, ejeMayorPxR2, ejeMayorPxR3, ejeMayorPxR4, ejeMenorPxR1, ejeMenorPxR2, ejeMenorPxR3, ejeMenorPxR4, diametrommR1, diametrommR2, diametrommR3, diametrommR4, ejeMayormmR1, ejeMayormmR2, ejeMayormmR3, ejeMayormmR4, ejeMenormmR1, ejeMenormmR2, ejeMenormmR3, ejeMenormmR4, clasificacionSize');
    fprintf('\n Creating file with fetures \n');
    fprintf('%s \n', filename);
    fprintf(fileID,'%6s \n',filaCabecera);
    fprintf(fileID,'%6s',rowToAdd);
else
    fprintf('Adding data to the existing file \n');
    fclose(fileIDTest);
    fprintf(fileID,'%6s',rowToAdd);
end

fclose(fileID);

end

