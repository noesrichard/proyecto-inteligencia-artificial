function testing_accuracy = calculate_accuracy(predictions, y_testing)

    acum = 0; 
    for i = 1 : length(y_testing)
        if predictions(i) == y_testing(i)
            acum = acum + 1; 
        end
    end
    
    testing_accuracy = acum/length(y_testing); 

end
