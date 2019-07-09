function sliderchanging
% Create figure window and components
clear
close all force
figr

fig = uifigure('Position',[100 100 350 275]);

cg = uigauge(fig,'Position',[100 100 120 120]);

label = uilabel(fig, 'Pos', [100 200 100 100],...
    'fontsize', 24);

sld = uislider(fig,...
               'Position',[100 75 120 3],...
               'ValueChangingFcn',@(sld,event) sliderMoving(event,cg,label));

end

% Create ValueChangingFcn callback
function sliderMoving(event,cg, label)
cg.Value = event.Value;
label.Text = num2str(event.Value);
end

function figr
H0 = uifigure;

label = uilabel(H0,...
    'Pos', [100 100 100 100],...
    'fontsize', 24);

sld = uislider(H0,...
    'ValueChangingFcn',@(sld,event) updatelabel(event, label));
end

function updatelabel(sld, label)
label.Text = num2str(sld.Value);
end