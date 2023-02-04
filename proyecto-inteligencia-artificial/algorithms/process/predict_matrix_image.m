function a_prediction = predict_matrix_image(img, algo)

    labels = get_labels();


    if contains(algo,'ann')
    
        observation = make_observation(img);
    
        a_prediction = annClassifier(observation);
        [value, index] = max(a_prediction);
    
        prediction = labels(index, "labels");
        a_prediction = char(prediction{:,1});
    else
    
        classifier = get_classifier(algo); 
    
    
        load(classifier);
    
        observation = make_observation(img);
    
        a_prediction = trainedClassifier.predictFcn(observation);
    
        prediction = labels(a_prediction, "labels");
        a_prediction = char(prediction{:,1});
    
        clear img labels prediction;
    end
end