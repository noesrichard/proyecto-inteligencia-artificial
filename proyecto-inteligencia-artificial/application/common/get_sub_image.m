function sub_image = get_sub_image(image, coords)
     
    sub_image = image(coords(1):coords(2),coords(3):coords(4),:);

end