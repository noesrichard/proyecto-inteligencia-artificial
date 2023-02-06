function predictions = app_predict_quadtree(image, resize, threshold, dims,algo, component)

    [image, modified_image, gray_image, bw_image] = preprocess_image(image, resize);

    [S, boxes, coords] = quadtree(gray_image,threshold,dims); 

    imshow(modified_image, 'Parent', component);
    if length(boxes) > 4
        hold(component,'on'); 
        predictions = app_predict(modified_image, boxes, algo, component); 
        hold(component,'off');
    end
end





