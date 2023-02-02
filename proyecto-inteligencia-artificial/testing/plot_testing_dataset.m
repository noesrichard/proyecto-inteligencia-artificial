clc; clear; close all; 
dataset = readmatrix('testing\dataset.xlsx'); 

x = dataset(:,1:end-1); 
%x = normalize(x); 
y = dataset(:,end); 


clr = [[0 0 0];
    [0 0 1];
    [0.8500 0.3250 0.0980];
    [0 1 0]; 
    [0.5 0.5 0.5];
    [0.9290 0.6940 0.1250]
    [1 0 0];
    [1 0 1];
    [0.97 0.75 0.88];
    [1 1 0] 
    ];

X = tsne(x); 
gscatter(X(:,1), X(:,2), y, clr); 