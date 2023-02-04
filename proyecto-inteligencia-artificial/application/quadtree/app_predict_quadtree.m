function predictions = app_predict_quadtree(image, resize, threshold, dims,algo, component)

    [image, modified_image, gray_image, bw_image] = preprocess_image(image, resize);

    [S, boxes, coords] = quadtree(gray_image,threshold,dims); 

    imshow(modified_image, 'Parent', component);
    if length(boxes) > 4
        hold(component,'on'); 
        predictions = predict(modified_image, boxes, coords, algo, component); 
        hold(component,'off');
        title(component,'BoundingBox')
    end
end


function  predictions = predict(image, boxes, coords, algo, component)

    predictions = [];

    for index = 1: length(boxes)
    
        sub_img = get_sub_image(image,coords(index,:));
        
        prediction = predict_matrix_image(sub_img,algo);
    
        prediction = convertCharsToStrings(prediction);
        
        draw_prediction(prediction, boxes(index,:), component);
       
        predictions = [predictions; index prediction];
    end

end

function draw_prediction(prediction, box, component)
    color = set_color(prediction);
    text(component, 'Position',[box(:,1) box(:,2)+10],'String',prediction, 'Color',color);
    rectangle(component, 'position', box(:,:), 'EdgeColor','r');
end

function color = set_color(prediction)
    color = 'k';
    if (contains(prediction, 'black') || contains(prediction, 'grey') ...
           || contains(prediction, 'blue') )
        color = 'w';
    end
end