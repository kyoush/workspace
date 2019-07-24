clear
close all force

f = figure(1);

A = imread('image2.jpeg');
image(A)

h = images.roi.Circle(gca, 'Center', [448 380], 'Radius', 50);

T = 20;
for i = 1:T
    a = h.Selected;
    pause(0.5)
    if a == 1
        disp('Selected')
        h.Selected = 0;
    end
end