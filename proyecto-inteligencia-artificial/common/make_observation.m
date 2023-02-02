function observation = make_observation(img)
    
    img = process_image(img); 
    
    imgRed = img(:,:,1); % red
    imgGreen = img(:,:,2); % green
    imgBlue = img(:,:,3); % blue
    
   
    meansB = extract_means_vector(imgBlue); 
    meansR = extract_means_vector(imgRed); 
    meansG = extract_means_vector(imgGreen); 
    
    observation = [meansR meansG meansB];
end