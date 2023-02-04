function [S, boxes, coords] = quadtree(gray_image, threshold, dims)
    S = qtdecomp(gray_image,threshold);
    boxes = [];
    coords = [];
    for dim = dims
        [values, rows, columns] = qtgetblk(gray_image,S,dim);
        dims_rep = repmat(dim,size(rows));
        boxes = [boxes; columns rows dims_rep dims_rep];
        coords = [coords; rows rows+dim-1 columns columns+dim-1];
    end
end