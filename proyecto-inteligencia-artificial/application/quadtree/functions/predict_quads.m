
function predictions = predict_quads(image, boxes, algo)

    predictions = [];

    for i = 1: length(boxes)
    
        sub_img = imcrop(image, boxes(i,:));

        prediction = predict_matrix_image(sub_img,algo);
    
        prediction = convertCharsToStrings(prediction);
       
        predictions = [predictions; i prediction];
    end

end
