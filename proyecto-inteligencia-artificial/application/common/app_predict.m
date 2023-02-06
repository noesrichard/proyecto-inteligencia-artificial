function  predictions = app_predict(image, boxes, algo, component)

    predictions = [];

    for i = 1: size(boxes,1)
    
        sub_img = imcrop(image, boxes(i,:));
        
        prediction = predict_matrix_image(sub_img,algo);
    
        prediction = convertCharsToStrings(prediction);
        
        app_draw_predictions(prediction, boxes(i,:), component);
       
        predictions = [predictions; i prediction];
    end

end