clear
close all force

x = 0:620/8921:619.95;
y = 0.5:0.1:892.5;
plot(x, y)
grid on
hold on
polyfit(x, y, 1)

for i = 1:5
    w = waitforbuttonpress;
    a = 1 + i;
    x2 = 0:0.1:620;
    y2 = a .* x2 + 0.5;
    if i ~= 1
        delete(tmp)
    end
    tmp = plot(x2, y2);
end