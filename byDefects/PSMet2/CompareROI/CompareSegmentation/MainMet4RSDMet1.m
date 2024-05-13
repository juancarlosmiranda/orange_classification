% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
% Genera imagenes de regiones previamente marcadas a MANO
% Es un proceso previo a la extraccion automatizada de caracteristicas.
% Se asume que un experto marco las frutas a mano con colores.
% Como salida se producen imágenes.

%% Initial parameter setting
clc; clear all; close all;
 
 %% Definicion de estructura de directorios 
HOME=fullfile('C:','Users','Usuari','development','orange_classification');
pathPrincipal=fullfile(HOME,'OrangeResults','byDefects','PSMet2','CompareROI');
pathEntradaImagenes=fullfile(HOME,'OrangeResults','inputToLearn');
pathEntradaMarca=fullfile(HOME,'OrangeResults','inputMarked');
pathConfiguracion=fullfile(pathPrincipal,'conf');
pathAplicacionCOMPARAR=fullfile(pathPrincipal,'tmpToLearn','CompareSDMet1');
pathAplicacionONLINE=fullfile(pathPrincipal,'tmpToLearn','SDMet1');
pathAplicacionMARCAS=fullfile(pathPrincipal,'tmpToLearn','MARKED');

nombreImagenP='nombreImagenP'; %imagen original


pathDefBinario=fullfile(pathAplicacionMARCAS,'MDefBin'); %almacenado de defectos binario POR MARCAS
pathCalyxBinario=fullfile(pathAplicacionMARCAS,'MCalyxBin'); %almacenado de calyx en binario POR MARCAS
pathExpertoBin=fullfile(pathAplicacionCOMPARAR,'ExpertoBin'); % resultados juntados calyx y defectos EXPERTO
%% software
pathDefectosBin=fullfile(pathAplicacionONLINE,'defectos'); % siluetas defectos por SOFTWARE ONLINE


%% 
pathFPFNBin=fullfile(pathAplicacionCOMPARAR,'FPFNBin'); % comparacion
pathTPTNBin=fullfile(pathAplicacionCOMPARAR,'TPTNBin'); % comparacion
pathFNBin=fullfile(pathAplicacionCOMPARAR,'FNBin'); % comparacion
pathFPBin=fullfile(pathAplicacionCOMPARAR,'FPBin'); % comparacion
pathTPBin=fullfile(pathAplicacionCOMPARAR,'TPBin'); % comparacion
pathTNBin=fullfile(pathAplicacionCOMPARAR,'TNBin'); % comparacion
pathTPFPFNBin=fullfile(pathAplicacionCOMPARAR,'TPFPFNBin'); % comparacion


%% Definición a cero de las variables promedio
acumuladoPrecision=0.0;
acumuladoExactitud=0.0;
acumuladoSensibilidad=0.0;
acumuladoEspecificidad=0.0;

promedioPrecision=0.0;
promedioExactitud=0.0;
promedioSensibilidad=0.0;
promedioEspecificidad=0.0;

listado=dir(fullfile(pathEntradaMarca,'*.jpg'));
%% lectura en forma de bach del directorio de la cámara

for n=1:size(listado)
    nombreImagenP=listado(n).name; % imagen principal
    % se asume que siempre existen 4 imagenes
    for ROI=1:4
        % creadas con el proceso de separacion de roi 
        nombreImagenDefBin=fullfile(pathDefBinario,strcat(nombreImagenP,'_','DEFB', int2str(ROI),'.jpg')); %mascara binaria defectos
        nombreImagenCalyxBin=fullfile(pathCalyxBinario,strcat(nombreImagenP,'_','CALB', int2str(ROI),'.jpg')); %mascara binaria calyx        
        % juntos, son los resultados que dio el EXPERTO defectos y calyx
        nombreMascaraExperto=fullfile(pathExpertoBin,strcat(nombreImagenP,'_','E', int2str(ROI),'.jpg'));

        %% defectos online SOFTWARE
        nombreImagenSoftware=fullfile(pathDefectosBin,strcat(nombreImagenP,'_','soM', int2str(ROI),'.jpg'));       
        nombreMascaraTPTN=fullfile(pathTPTNBin,strcat(nombreImagenP,'_','TPTN', int2str(ROI),'.jpg'));
        nombreMascaraFPFN=fullfile(pathFPFNBin,strcat(nombreImagenP,'_','FPFN', int2str(ROI),'.jpg'));
        nombreMascaraFN=fullfile(pathFNBin,strcat(nombreImagenP,'_','FN', int2str(ROI),'.jpg'));
        nombreMascaraFP=fullfile(pathFPBin,strcat(nombreImagenP,'_','FP', int2str(ROI),'.jpg'));
        nombreMascaraTP=fullfile(pathTPBin,strcat(nombreImagenP,'_','TP', int2str(ROI),'.jpg'));        
        nombreMascaraTN=fullfile(pathTNBin,strcat(nombreImagenP,'_','TN', int2str(ROI),'.jpg'));        
        nombreMascaraTPFPFN=fullfile(pathTPFPFNBin,strcat(nombreImagenP,'_','TO', int2str(ROI),'.jpg'));
        
        
        %% JUNTAR MARCAS
%        fprintf('JUNTANDO REGIONES de clases del EXPERTO-> %s R=%i\n',listado(n).name,ROI);    
        juntado(nombreImagenCalyxBin,nombreImagenDefBin, nombreMascaraExperto);
        %% DIFERENCIAS FALSE POSITIVE Y FALSE NEGATIVE
%        fprintf('FN Y FP -> DIFERENCIAS EXPERTO VS SOFTWARE-> %s R=%i \n',listado(n).name, ROI);        
        diferencia(nombreMascaraExperto, nombreImagenSoftware, nombreMascaraFPFN);
        %% obtener FN
%        fprintf('BUSCANDO FN -> EXPERTO VS FPFN %s R=%i \n',listado(n).name, ROI);
        coincidencia(nombreMascaraExperto, nombreMascaraFPFN, nombreMascaraFN);
        %% obtener FP
%        fprintf('BUSCANDO FP -> SOFTWARE VS FPFN %s R=%i \n',listado(n).name, ROI);        
        coincidencia(nombreImagenSoftware, nombreMascaraFPFN, nombreMascaraFP);
        %% obtener TPTN
%        fprintf('BUSCANDO TP -> EXPERTO VS SOFTWARE %s R=%i \n',listado(n).name, ROI);
        coincidencia(nombreMascaraExperto, nombreImagenSoftware, nombreMascaraTP);
    
%        fprintf('TN NOT EXPERTO + SOFTWARE -> %s R=%i \n',listado(n).name, ROI);  
        juntado(nombreMascaraExperto,nombreImagenSoftware, nombreMascaraTPFPFN);
        %% hace la inversa para contar en pixeles los TN
        inversa(nombreMascaraTPFPFN, nombreMascaraTN);

        %% CALCULAR TASA DE DIFERENCIAS Y COINCIDENCIAS
        %% Definicion de variables a cero
        TP=0;
        TN=0;    
        FP=0;
        FN=0;
        
        precision=0.0;
        exactitud=0.0;
        sensibilidad=0.0;
        especificidad=0.0;
        
        %% conteo de pixeles
        TP=contarPixeles(nombreMascaraTP);    
        FP=contarPixeles(nombreMascaraFP);
        FN=contarPixeles(nombreMascaraFN);
        TN=contarPixeles(nombreMascaraTN);
    
        %precision, exactitud, sensibilidad, especificidad
        if((TP+FP)==0)
            precision=0;
        else
            precision=TP/(TP+FP);            
        end

        
        if((TP+FP+TN+FN)==0)
            exactitud=0;
        else
            exactitud=(TP+TN)/(TP+FP+TN+FN);
        end        

        if((TP+FN)==0)
            sensibilidad=0;
        else
            sensibilidad=TP/(TP+FN);
        end        


        if((TN+FP)==0)
            especificidad=0;
        else
            especificidad=TN/(TN+FP);
        end        
            
        %% acumulados
        acumuladoPrecision=acumuladoPrecision+precision;
        acumuladoExactitud=acumuladoExactitud+exactitud;
        acumuladoSensibilidad=acumuladoSensibilidad+sensibilidad;
        acumuladoEspecificidad=acumuladoEspecificidad+especificidad;

        %% ------------------
        fprintf('imagen=%s, ROI=%i -> precision=%f, exactitud=%f,sensibilidad=%f especificidad=%f\n', nombreImagenP, ROI, precision, exactitud, sensibilidad, especificidad);
        
    end %fin de procesar 4 imagenes
       
    %% CALCULAR PROMEDIO
    %% GUARDAR EN ARCHIVO
    %if n==1
    %    break;
    %end;
end %
totalPruebas=n*4;
       
%% CALCULO DE PROMEDIO
promedioPrecision=acumuladoPrecision/totalPruebas;
promedioExactitud=acumuladoExactitud/totalPruebas;    
promedioSensibilidad=acumuladoSensibilidad/totalPruebas;
promedioEspecificidad=acumuladoEspecificidad/totalPruebas;

fprintf('--------------------------------\n');
fprintf('RESULTADO PROMEDIO EN %i PRUEBAS\n', totalPruebas);
fprintf('--------------------------------\n');    
fprintf('APrecision=%f, AExactitud=%f, ASensibilidad=%f AEspecificidad=%f\n', acumuladoPrecision, acumuladoExactitud,acumuladoSensibilidad, acumuladoEspecificidad);
fprintf('precision=%f, exactitud=%f, sensibilidad=%f especificidad=%f\n', promedioPrecision, promedioExactitud, promedioSensibilidad, promedioEspecificidad);
