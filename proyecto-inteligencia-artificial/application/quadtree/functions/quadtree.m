function [S, boxes, coords] = quadtree(gray_image, threshold, dims)
    S = qtdecomp(gray_image,threshold);
    boxes = [];
    coords = [];
    for dim = dims
        [values, rows, columns] = qtgetblk(gray_image,S,dim);
        dims = repmat(dim,size(rows));
        boxes = [boxes; columns rows dims dims];
        coords = [coords; rows rows+dim-1 columns columns+dim-1];
    end
end