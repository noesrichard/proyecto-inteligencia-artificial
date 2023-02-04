function [accuracy_testing, accuracy_training] = execute_testing(algo)
  
    
    classifier = get_classifier(algo); 
    
    load(classifier); 
    
    
   
    dataset_path = 'testing\dataset.xlsx'; 
    testing_dataset = readmatrix(dataset_path);  
    
    x_testing = testing_dataset(:,1:end-1); 

    y_testing = testing_dataset(:,end); 
    
    predictions = trainedClassifier.predictFcn(x_testing);
    
    accuracy_testing = calculate_accuracy(predictions, y_testing); 
    accuracy_training = trainedClassifier.Accuracy; 
end