clc; clear all; close all; 

%% KNN  
algo = 'knn';
trainedClassifier = execute_training(algo);

%% DT  
algo = 'dt';
trainedClassifier = execute_training(algo);

%% SVM
algo = 'svm';
trainedClassifier = execute_training(algo);

%% ANN
dataset_path = 'training\dataset_augmentation.xlsx'; 
dataset = readmatrix(dataset_path);
x = dataset(:,1:end-1); 
y = dataset(:,end);

numClasses = unique(y);
oneHotEnconding = (y==1:length(numClasses));
