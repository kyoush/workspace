function buttonPlot
% Create a figure window

clear
close all

fig = uifigure;

% Create a UI axes
ax = uiaxes('Parent',fig,...
            'Units','pixels',...
            'Position', [104, 123, 300, 201]);   

% Create a push button
uibutton(fig,'push',...
               'Position',[420, 218, 100, 22],...
               'ButtonPushedFcn', @(btn,event) plotButtonPushed(ax));
end

% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(ax)
        x = linspace(0,2*pi,100);
        y = sin(x);
        plot(ax,x,y)
end