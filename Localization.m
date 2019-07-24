function Localization(WIDTH, HEIGHT, f, h, sld_itd, sld_ild)
global store
global plt
delete(plt)
v = get(0, 'MonitorPosition');
p = get(gca, 'Position');
xlim = get(gca, 'xlim');
ylim = get(gca, 'ylim');
hold on

a = (xlim(2) - xlim(1))/(p(3) * WIDTH);
b = (ylim(1) - ylim(2))/(p(4) * HEIGHT);

% disp(store.xpos)

v = f.Position;
x0 = v(1) + p(1) * WIDTH;
y0 = v(2) + p(2) * HEIGHT;
w = waitforbuttonpress;
xy = get(0, 'PointerLocation');
x = xy(1, 1) - x0;
y = xy(1, 2) - y0;
xp = a * x;
yp = b * y + ylim(2);

plt = plot(xp, yp, 'r.', 'MarkerSize', 160);
store.itd = [store.itd sld_itd.Value];
store.ild = [store.ild sld_ild.Value];
store.xpos = [store.xpos xp];
store.ypos = [store.ypos yp];

end