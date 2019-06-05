tmp = 1;
rd = rand();
rd = int8(rd * 10.^tmp);

for i = 1 : 100
    disp([i, fix(i/10), tmp, rd])
    if fix(i/10) > tmp
        tmp = fix(i/10);
        rd = int8(rand() * 10.^tmp);
%         disp([tmp, rd])
    end
    if i == rd
        disp([i, rd])
        disp(sqrt(i))
    end
end