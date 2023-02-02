function means = extract_means_vector(spectrum)

  
    spectrum = reshape(spectrum.',1,[]);
    [rows, columns] = size(spectrum); 

    window = columns/10;
    column_end = window; 

    means = [];
    j = 1; 
    
    for i = 1 : window : columns
        means(j) = mean(spectrum(1,i:column_end));
        column_end = column_end + window; 
        j = j + 1; 
    end
end