clc; clear; close all; 

warning("off", "all"); 

image = imread('application\images\person.jpg');

predictions = predict_regionprops(image,'ann', true, 0.2); 
