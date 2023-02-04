function classifier = get_classifier(algo) 
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
end