function trainedClassifier = execute_training(algo)
    dataset_path = 'training\dataset_augmentation.xlsx'; 
    dataset = readmatrix(dataset_path);
    
    x = dataset(:,1:end-1); 

    y = dataset(:,end);
    
    classifier = get_classifier(algo); 

    delete(fullfile(save_path));
    trainedClassifier.Accuracy = accuracy; 
    save(save_path, 'trainedClassifier'); 
end