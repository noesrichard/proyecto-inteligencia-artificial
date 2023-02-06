
function color = set_color(prediction)
    color = 'k';
    if (contains(prediction, 'black') || contains(prediction, 'grey') ...
           || contains(prediction, 'blue') )
        color = 'w';
    end
end