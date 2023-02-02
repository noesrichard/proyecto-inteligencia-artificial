clc; clear; close all;
testing_image_path = 'testing\data\orange\52.jpeg';
%% KNN  
algo = 'knn';
[accuracy_testing_knn, accuracy_training_knn] = execute_testing(algo); 
prediction_knn = predict_image(testing_image_path, algo); 
 
%% DT  
algo = 'dt';
[accuracy_testing_dt, accuracy_training_dt] = execute_testing(algo); 
prediction_knn = predict_image(testing_image_path, algo); 
 
%% SVM
algo = 'svm';
[accuracy_testing_svm, accuracy_training_svm] = execute_testing(algo); 
prediction_knn = predict_image(testing_image_path, algo); 
 
%% ANN
dataset_path = 'testing\dataset.xlsx'; 
testing_dataset = readmatrix(dataset_path);  
x_testing = testing_dataset(:,1:end-1); 
y_testing = testing_dataset(:,end); 

predictions = annClassifier(x_testing);
[val,idx] = max(predictions');
accuracy_testing_ann = sum(idx' == y_testing)/length(x_testing);

clear dataset_path idx predictions testing_dataset testing_dataset val x_testing y_testing; 