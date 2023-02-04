function predictions = predict_and_draw_quads(image, boxes, coords, algo)
    imshow(image);
    hold on
    predictions = predict(image, boxes, coords, algo); 
    hold off
end


function  predictions = predict(image, boxes, coords, algo)

    predictions = [];

    for index = 1: length(boxes)
    
        sub_img = get_sub_image(image,coords(index,:));
        
        prediction = predict_matrix_image(sub_img,algo);
    
        prediction = convertCharsToStrings(prediction);
        
        draw_prediction(prediction, boxes(index,:));
       
        predictions = [predictions; index prediction];
    end

end

function draw_prediction(prediction, box)
    color = set_color(prediction);
    text('Position',[box(:,1) box(:,2)+10],'String',prediction, 'Color',color);
    rectangle('position', box(:,:), 'EdgeColor','r','LineWidth',2);
end

function color = set_color(prediction)
    color = 'k';
    if (contains(prediction, 'black') || contains(prediction, 'grey') ...
           || contains(prediction, 'blue') )
        color = 'w';
    end
end