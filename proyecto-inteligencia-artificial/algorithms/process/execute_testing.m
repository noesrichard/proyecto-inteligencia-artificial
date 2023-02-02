function [accuracy_testing, accuracy_training] = execute_testing(algo)
%% Carga
    
    classifier = 'algorithms\knn\knnClassifier.mat'; 
    
    switch algo
        case 'knn'
            classifier = 'algorithms\knn\knnClassifier.mat';
        case 'dt'
            classifier = 'algorithms\dt\dtClassifier.mat';
        case 'svm'
            classifier = 'algorithms\svm\svmClassifier.mat';
        otherwise
            warning('Algoritmo no valido, por defecto knn');
    end
    
    load(classifier); 
    
    
    %% Testeo vario
    dataset_path = 'testing\dataset.xlsx'; 
    testing_dataset = readmatrix(dataset_path);  
    
    x_testing = testing_dataset(:,1:end-1); 

    y_testing = testing_dataset(:,end); 
    
    predictions = trainedClassifier.predictFcn(x_testing);
    
    accuracy_testing = calculate_accuracy(predictions, y_testing); 
    accuracy_training = trainedClassifier.Accuracy; 
end