function predictions = draw_predictions(image, boxes, algo)
    imshow(image);
    hold on
    predictions = predict(image, boxes, algo); 
    hold off
end


function  predictions = predict(image, boxes, algo)

    predictions = [];

    for i = 1: length(boxes)
    
        sub_img = imcrop(image, boxes(i,:));
        
        prediction = predict_matrix_image(sub_img,algo);
    
        prediction = convertCharsToStrings(prediction);
        
        draw_prediction(prediction, boxes(i,:));
       
        predictions = [predictions; i prediction];
    end

end

function draw_prediction(prediction, box)
    color = set_color(prediction);
    text('Position',[box(:,1) box(:,2)+10],'String',prediction, 'Color',color);
    rectangle('position', box(:,:), 'EdgeColor','r');
end

function color = set_color(prediction)
    color = 'k';
    if (contains(prediction, 'black') || contains(prediction, 'grey') ...
           || contains(prediction, 'blue') )
        color = 'w';
    end
end