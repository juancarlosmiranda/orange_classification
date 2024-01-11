% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
%% Creador de conjuntos de entrenamiento y pruebas
% Se encarga de crear un conjunto de entrenamiento y pruebas al azar.
% Crea un listado inicial de imágenes a partir de un directorio de muestras, las cuales
% cuentan con su correspondencia de marcas realizadas por el experto. Es decir
% 001.jpg original tiene su contrapartida como 001.jpg marcada por el
% experto.


% * Leer el DIRECTORIO principal de imagenes.
% * Leer los valores de proporcion de los conjuntos.
% * Leer tabla del archivo conjunto principal.
% * Tomando el set principal, crear en forma aleatoria el conjunto para
% TEST y para TRAINING. Genera dos directorios con imágenes copiadas.
%
% Update and refactoring: December 2023


%% Ajuste de parámetros iniciales
clc; clear all; close all;

%HOME=strcat(pwd,'/');
% IMPORTANT!!! CONFIGURE HERE THE MAIN FOLDER FOR YOUR PROJECT
HOME=fullfile('C:','Users','Usuari','development','orange_classification');
pathPrincipal=fullfile(HOME,'OrangeResults','byDefects','PSMet2','SetCreator');
pathResultados=fullfile(pathPrincipal,'output');

nombreArchivoSetCompleto='setCompleto.csv'; % todo: 12/12/2023 change this name


%% Apertura del diario de pantallas
%diary(fileHandlerDiary)


%% Ingresar parametros, porcentaje utilizado para entrenamiento
proporcionTraining=70;

 %% Definicion de estructura de directorios 
pathEntradaImagenes=fullfile(HOME,'OrangeResults','inputToLearn'); % imagenes originales, inputMarked imagenes marcadas por experto DATASET
pathEntradaImagenesMarcas=fullfile(HOME,'OrangeResults','inputMarked');
pathEntradaImagenesTest=fullfile(HOME,'OrangeResults','inputTest');
pathEntradaImagenesTraining=fullfile(HOME,'OrangeResults','inputTraining');


%carga del listado de nombres
listado=dir(fullfile(pathEntradaImagenes,'*.jpg'));
[tablaDSTraining, tablaDSTest]=splitSetImg( listado, proporcionTraining, pathPrincipal, pathResultados, nombreArchivoSetCompleto);
%% borrado de test y de training
%|__/DATASET/
%       |__/inputToLearn/ -> BD de datos inicial
%       |__/inputMarked/ -> BD on correspondencia marcadas
%       |__/inputTest -> se borra y se crea con las imagenes
%       |__/inputTraining -> se borra y se crea con las imagenes
%
%% copiar de
archivosProbar=fullfile(pathEntradaImagenesTest,'*.jpg');
removeFiles(archivosProbar);

archivosTraining=fullfile(pathEntradaImagenesTraining,'*.jpg');
removeFiles(archivosTraining);

copyDirectory( tablaDSTest, pathEntradaImagenes, pathEntradaImagenesTest);
copyDirectory( tablaDSTraining, pathEntradaImagenesMarcas, pathEntradaImagenesTraining);
%% -------------------------------------------------------------------