function a_prediction = predict_image(path, algo) 
%% Testeo unico
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

    img = imread(path);
    labels = readtable('labels.xlsx'); 
    
    observation = make_observation(img);
    
    a_prediction = trainedClassifier.predictFcn(observation);
    
    prediction = labels(a_prediction, "labels");
    a_prediction = char(prediction{:,1});
    
    clear img labels prediction;
end