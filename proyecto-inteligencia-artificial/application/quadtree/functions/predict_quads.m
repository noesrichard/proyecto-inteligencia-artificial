
function predictions = predict_quads(image, boxes, coords, algo)

    predictions = [];

    for index = 1: length(boxes)
    
        sub_img = get_sub_image(image,coords(index,:));
        
        prediction = predict_matrix_image(sub_img,algo);
    
        prediction = convertCharsToStrings(prediction);
       
        predictions = [predictions; index prediction];
    end

end