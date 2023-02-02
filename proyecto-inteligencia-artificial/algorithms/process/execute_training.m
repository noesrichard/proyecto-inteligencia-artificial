function trainedClassifier = execute_training(algo)
    dataset_path = 'training\dataset_augmentation.xlsx'; 
    dataset = readmatrix(dataset_path);
    
    x = dataset(:,1:end-1); 

    y = dataset(:,end);
    
    save_path = 'algorithms\knn\knnClassifier.mat';
    
    switch algo
        case 'knn'
            [trainedClassifier, accuracy] = knnClassifier(x,y);  
            save_path = 'algorithms\knn\knnClassifier.mat';
        case 'dt'
            [trainedClassifier, accuracy] = dtClassifier(x,y);
            save_path = 'algorithms\dt\dtClassifier.mat';
        case 'svm'
           [trainedClassifier, accuracy] = svmClassifier(x,y);
            save_path = 'algorithms\svm\svmClassifier.mat';
        otherwise
            warning('Algoritmo no valido, por defecto knn');
    end
    delete(fullfile(save_path));
    trainedClassifier.Accuracy = accuracy; 
    save(save_path, 'trainedClassifier'); 
end