function [ ] = ExtractMarkedRegions(pathEntrada, pathAplicacion, nombreImagenP)
% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
% Extrae los defectos de las naranjas, genera como salida un archivo con
% datos separados por comas y genera imagenes intermedias con los defectos
% en, la fruta y los defectos, el contorno de las frutas.
%
% tamanoManchas representa el tamano en pixeles, se utiliza para eliminar
% manchas pequenas y dejar un contorno de la fruta. El objetivo final es
% obtener solaente las manchas.
%
% Se generan imagenes intermedias que corresponden a:
% * imagen generada previamente con fondo removido
% * imagen intermedia con frutas y defectos
% * solamente los defectos aislados
%
% -----------------------------------------------------------------------

%% Datos de configuración archivos
imagenInicial=fullfile(pathEntrada,nombreImagenP); %para escritura en archivo de resultados


pathAplicacion3=fullfile(pathAplicacion,'IRM'); %imagen generada previamente con fondo removido


%pathAplicacion4=strcat(pathAplicacion,'sDefectos/'); %imagen intermedia con frutas y defectos
%pathAplicacion5=strcat(pathAplicacion,'defectos/'); %solamente los defectos aislados
pathAplicacion6=fullfile(pathAplicacion,'cDefectos');
%pathAplicacion7=strcat(pathAplicacion,'contornos/'); %contornos de frutas

%% CONFIGURACIONES DEFECTOS MASCARA Y COLOR
pathCalyxColor=fullfile(pathAplicacion,'cCalyx'); %almacenado de calyx en color
pathCalyxBinario=fullfile(pathAplicacion,'MCalyxBin'); %almacenado de calyx en binario

pathDefColor=fullfile(pathAplicacion,'cDefColor'); %almacenado de defectos color
pathDefBinario=fullfile(pathAplicacion,'MDefBin'); %almacenado de defectos binario


%pathTodosBin=strcat(pathAplicacion,'todosBin/'); %juntado


% nombres de archivos con objetos removidos
nombreImagenRemovida1=fullfile(pathAplicacion3,strcat(nombreImagenP,'_','rm1.jpg'));
nombreImagenRemovida2=fullfile(pathAplicacion3,strcat(nombreImagenP,'_','rm2.jpg'));
nombreImagenRemovida3=fullfile(pathAplicacion3,strcat(nombreImagenP,'_','rm3.jpg'));
nombreImagenRemovida4=fullfile(pathAplicacion3,strcat(nombreImagenP,'_','rm4.jpg'));


%nombreImagenRemovidaMarca1=strcat(pathAplicacionRemMarca,nombreImagenP,'_','Mrm1.jpg');
%nombreImagenRemovidaMarca2=strcat(pathAplicacionRemMarca,nombreImagenP,'_','Mrm2.jpg');
%nombreImagenRemovidaMarca3=strcat(pathAplicacionRemMarca,nombreImagenP,'_','Mrm3.jpg');
%nombreImagenRemovidaMarca4=strcat(pathAplicacionRemMarca,nombreImagenP,'_','Mrm4.jpg');


    %% salida segmentacion
%    nombreImagenSalida1=strcat(pathAplicacion4,nombreImagenP,'_','so1.jpg');
%    nombreImagenSalida2=strcat(pathAplicacion4,nombreImagenP,'_','so2.jpg');
%    nombreImagenSalida3=strcat(pathAplicacion4,nombreImagenP,'_','so3.jpg');
%    nombreImagenSalida4=strcat(pathAplicacion4,nombreImagenP,'_','so4.jpg');

    %% salida defectos
%    nombreImagenDefectos1=strcat(pathAplicacion5,nombreImagenP,'_','soM1.jpg');
%    nombreImagenDefectos2=strcat(pathAplicacion5,nombreImagenP,'_','soM2.jpg');
%    nombreImagenDefectos3=strcat(pathAplicacion5,nombreImagenP,'_','soM3.jpg');
%    nombreImagenDefectos4=strcat(pathAplicacion5,nombreImagenP,'_','soM4.jpg');

    %% salida defectos en COLOR
    nombreImagenDefectosC1=fullfile(pathAplicacion6,strcat(nombreImagenP,'_','soC1.jpg'));
    nombreImagenDefectosC2=fullfile(pathAplicacion6,strcat(nombreImagenP,'_','soC2.jpg'));
    nombreImagenDefectosC3=fullfile(pathAplicacion6,strcat(nombreImagenP,'_','soC3.jpg'));
    nombreImagenDefectosC4=fullfile(pathAplicacion6,strcat(nombreImagenP,'_','soC4.jpg'));
   
    
    %% salida contornos
%    nombreImagenContorno1=strcat(pathAplicacion7,nombreImagenP,'_','CM1.jpg');
%    nombreImagenContorno2=strcat(pathAplicacion7,nombreImagenP,'_','CM2.jpg');
%    nombreImagenContorno3=strcat(pathAplicacion7,nombreImagenP,'_','CM3.jpg');
%    nombreImagenContorno4=strcat(pathAplicacion7,nombreImagenP,'_','CM4.jpg');
    

    %DEFINICION DE NOMBRES DE IMAGENES PARA CALYX SEGMENTADO EN COLOR Y EN
    %BINARIO
    nombreImagenCalyxColor1=fullfile(pathCalyxColor,strcat(nombreImagenP,'_','CALC1.jpg')); % imagen en color calyx
    nombreImagenCalyxColor2=fullfile(pathCalyxColor,strcat(nombreImagenP,'_','CALC2.jpg'));
    nombreImagenCalyxColor3=fullfile(pathCalyxColor,strcat(nombreImagenP,'_','CALC3.jpg'));
    nombreImagenCalyxColor4=fullfile(pathCalyxColor,strcat(nombreImagenP,'_','CALC4.jpg'));    

    nombreImagenCalyxBin1=fullfile(pathCalyxBinario,strcat(nombreImagenP,'_','CALB1.jpg')); %mascara binaria calyx
    nombreImagenCalyxBin2=fullfile(pathCalyxBinario,strcat(nombreImagenP,'_','CALB2.jpg'));
    nombreImagenCalyxBin3=fullfile(pathCalyxBinario,strcat(nombreImagenP,'_','CALB3.jpg'));
    nombreImagenCalyxBin4=fullfile(pathCalyxBinario,strcat(nombreImagenP,'_','CALB4.jpg'));    

    

    %DEFINICION DE NOMBRES DE IMAGENES PARA DEFECTOS SEGMENTADO EN COLOR Y EN
    %BINARIO
%    nombreImagenDefColor1=strcat(pathDefColor,nombreImagenP,'_','DEFC1.jpg'); % imagen en color calyx
%    nombreImagenDefColor2=strcat(pathDefColor,nombreImagenP,'_','DEFC2.jpg');
%    nombreImagenDefColor3=strcat(pathDefColor,nombreImagenP,'_','DEFC3.jpg');
%    nombreImagenDefColor4=strcat(pathDefColor,nombreImagenP,'_','DEFC4.jpg');    

    nombreImagenDefBin1=fullfile(pathDefBinario,strcat(nombreImagenP,'_','DEFB1.jpg')); %mascara binaria calyx
    nombreImagenDefBin2=fullfile(pathDefBinario,strcat(nombreImagenP,'_','DEFB2.jpg'));
    nombreImagenDefBin3=fullfile(pathDefBinario,strcat(nombreImagenP,'_','DEFB3.jpg'));
    nombreImagenDefBin4=fullfile(pathDefBinario,strcat(nombreImagenP,'_','DEFB4.jpg'));    
    
    
    %% siluetas juntadas
%    nombreMascaraFinal1=strcat(pathTodosBin,nombreImagenP,'_','B1.jpg');
%    nombreMascaraFinal2=strcat(pathTodosBin,nombreImagenP,'_','B2.jpg');    
%    nombreMascaraFinal3=strcat(pathTodosBin,nombreImagenP,'_','B3.jpg');    
%    nombreMascaraFinal4=strcat(pathTodosBin,nombreImagenP,'_','B4.jpg');    
    
    
%% GRANULOMETRIAS
%tamanoManchas=1000; %1000 sacabuenos contornos
   
%% -- BEGIN DEFECTS FEATURES EXTRACTION ----------------------------------
%% Segmentacion de mascara para obtener defectos aislados de ROI
%fprintf('Segmentacion de mascara para obtener defectos aislados de ROI CALYX--> \n');
%% Separación de calyx pintado
fprintf('Separación de CALYX pintados en color CALYX--> \n');
backgroundRemoval4(nombreImagenRemovida1, nombreImagenCalyxBin1, nombreImagenCalyxColor1);
backgroundRemoval4(nombreImagenRemovida2, nombreImagenCalyxBin2, nombreImagenCalyxColor2);
backgroundRemoval4(nombreImagenRemovida3, nombreImagenCalyxBin3, nombreImagenCalyxColor3);
backgroundRemoval4(nombreImagenRemovida4, nombreImagenCalyxBin4, nombreImagenCalyxColor4);

   
%% Separación de DEFECTOS pintado
fprintf('Separación de DEFECTOS pintados en color DEFECTOS--> \n');
% aqui se apartan las manchas en colores, tomando la máscara marcada por el
% experto.
backgroundRemoval4(nombreImagenRemovida1, nombreImagenDefBin1, nombreImagenDefectosC1);
backgroundRemoval4(nombreImagenRemovida2, nombreImagenDefBin2, nombreImagenDefectosC2);
backgroundRemoval4(nombreImagenRemovida3, nombreImagenDefBin3, nombreImagenDefectosC3);
backgroundRemoval4(nombreImagenRemovida4, nombreImagenDefBin4, nombreImagenDefectosC4);

%% -- END DEFECTS FEATURES EXTRACTION ----------------------------------
    
% -----------------------------------------------------------------------
end %end proceso completo

