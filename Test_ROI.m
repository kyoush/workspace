clear
close all force

f = figure(1);

A = imread('image2.jpeg');
image(A)

h = images.roi.Circle(gca, 'Center', [448 380], 'Radius', 50);

