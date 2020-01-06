function [] = hw2()
    clc;
    I = zeros(100,100);
    value = 50;
    ox = 50; oy = 50;
    a = 20; b = 10; h = 1;
    A = a*a; B = b*b;

    d = h*(B*h - A*(2*b - h));
    x = 0;
    y = b;

    while y >= (B/A)*x
       I = fourSymetric(I, ox, oy, x, y, value);
       disp([1, x, y, d, A*h*(2*y-h)]);
       if (2*d < -A*h*(2*y-h)) %H
            d = d + 2*B*h*(x+h);
            x = x + h;
       else %D
            d = d + 2*B*h*(x+h) - 2*A*h*(y-h);
            x = x + h;
            y = y - h;
       end
    end
    
    while y >= 0
       I = fourSymetric(I, ox, oy, x, y, value);
       disp([2, x, y, d, B*h*(2*x+h)]);
       if (2*d > B*h*(2*x+h)) %V
            d = d - 2*A*h*(y-h);
            y = y - h;
       else %D
            d = d + 2*B*h*(x+h) - 2*A*h*(y-h);
            x = x + h;
            y = y - h;
       end
    end

    image(transpose(I))
end

function newImage = fourSymetric(I, ox, oy, x, y, value)
    newImage = I;
    %I
    newImage(ox+x, oy+y) = value;
    %II
    newImage(ox-x, oy+y) = value;
    %III
    newImage(ox-x, oy-y) = value;
    %IV
    newImage(ox+x, oy-y) = value;
end