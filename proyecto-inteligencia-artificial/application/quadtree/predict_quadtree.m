function  predictions = predict_quadtree(img, resize, threshold, dims,algo, draw)  

    [image, modified_image, gray_image, bw_image] = preprocess_image(img, resize);

    [S, boxes, coords] = quadtree(gray_image,threshold,dims); 
    if length(boxes) > 4
        if draw
            predictions = predict_and_draw_quads(modified_image, boxes, algo); 
        else
            predictions = predict_quads(modified_image, boxes, algo);
        end
    end

end