function a_prediction = predict_image(path, algo) 
%% Testeo unico
    classifier = get_classifier(algo); 
    load(classifier);

    img = imread(path);
    labels = readtable('labels.xlsx'); 
    
    observation = make_observation(img);
    
    a_prediction = trainedClassifier.predictFcn(observation);
    
    prediction = labels(a_prediction, "labels");
    a_prediction = char(prediction{:,1});
    
    clear img labels prediction;
end