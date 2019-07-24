clear
close all

H0 = figure();

sld = uicontrol(H0,...
    'Style', 'slider');

% 
% X_MIN = 200;
% Y_MIN = 200;
% WIDTH = 600;
% HEIGHT = 620;
% position = [X_MIN Y_MIN WIDTH HEIGHT];
% 
% f = figure('Pos', position);
% 
% A = imread('image1.jpeg');
% image(A);
% 
% 
% h = drawcircle('Center',[1000,1000],'Radius',500,'StripeColor','red');
% 
% 
% 
% 
% % 
% % v = get(0, 'MonitorPosition');
% % 
% 
% while 1
%     w = waitforbuttonpress;
%     xy = get(0, 'PointerLocation');
%     clf
%     line([278 743], [268.2 773.5])
%     x = xy(1, 1);
%     y = xy(1, 2);
% 
%     disp([x y])
%     hold on
%     plot(x, y, 'b.', 'MarkerSize', 120);
% end