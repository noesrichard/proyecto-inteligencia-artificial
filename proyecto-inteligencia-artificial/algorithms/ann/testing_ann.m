clc; clear; close all; 
%% Testeo unico
img = imread("testing\data\grey\istockphoto-184652566-170667a.jpg");
labels = readtable('labels.xlsx'); 

observation = make_observation(img);

a_prediction = annClassifier(observation);
[value, index] = max(a_prediction); 

prediction = labels(index, "labels");
a_prediction = char(prediction{:,1});

clear img labels prediction ; 


%% Testeo vario

testing_dataset = readmatrix("testing\dataset.xlsx"); 

x_testing = testing_dataset(:,1:end-1); 
y_testing = testing_dataset(:,end); 

predictions = annClassifier(x_testing);

[val,idx] = max(predictions');
accuracy_testing = sum(idx' == y_testing)/length(x_testing);
 
