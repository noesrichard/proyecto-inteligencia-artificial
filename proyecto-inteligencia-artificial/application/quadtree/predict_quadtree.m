function  predictions = predict_quadtree(img,  threshold, dims,algo, draw, multi_boxes_flag)


    if multi_boxes_flag
        predictions = multi_boxes(img, threshold, dims, algo, draw);
    else
        [rows, columns, ~] = size(img); 
          
        rows = round(rows/2)-(512/2); 
        columns = round(columns/2)-(512/2); 
        end_v = 512 - 1; 
        new_img(:,:,1) = img(rows:rows+end_v, columns:columns+end_v,1); 
        new_img(:,:,2) = img(rows:rows+end_v, columns:columns+end_v,2);
        new_img(:,:,3) = img(rows:rows+end_v, columns:columns+end_v,3);
        predictions = centered(new_img,threshold, dims, algo, draw); 
    end


end

function predictions = centered(image, threshold, dims, algo, draw)
    gray_image = rgb2gray(image); 
    [S, boxes, coords] = quadtree(gray_image,threshold,dims); 
    if length(boxes) > 4
        if draw
            predictions = draw_predictions(image, boxes, algo); 
        else
            predictions = predict_quads(image, boxes, algo);
        end
    end

end

function predictions = multi_boxes(img, threshold, dims, algo, draw)

    [image, gr1, gr2, gr3, gr4] = preprocess_image(img, 512);
    [rows, columns, ~] = size(image); 
   
    [~, bxs1,  ~] = quadtree(gr1, threshold, dims);
    [~, bxs2,  ~] = quadtree(gr2, threshold, dims);
    [~, bxs3,  ~] = quadtree(gr3, threshold, dims);
    [~, bxs4,  ~] = quadtree(gr4, threshold, dims);
    
    bxs2(:,1) = bxs2(:,1)+columns-511;
    bxs3(:,2) = bxs3(:,2)+rows-511;
    bxs4(:,1) = bxs4(:,1)+columns-511;
    bxs4(:,2) = bxs4(:,2)+rows-511;

    imshow(image)
    hold on

    if length(bxs1) > 4
        if draw
            predictions = draw_predictions_qt(image, bxs1, algo);
        else
            predictions = predict_quads(image, bxs1, algo);
        end
    end
    if length(bxs2) > 4
        if draw
            predictions = draw_predictions_qt( image,  bxs2, algo);
        else
            predictions = predict_quads( image,  bxs2, algo);
        end
    end
    if length(bxs3) > 4
        if draw
            predictions = draw_predictions_qt( image,  bxs3, algo);
        else
            predictions = predict_quads( image,  bxs3, algo);
        end
    end
    if length(bxs4) > 4
        if draw
            predictions = draw_predictions_qt( image,  bxs4, algo);
        else
            predictions = predict_quads( image,  bxs4, algo);
        end
    end
    hold off
  
end

