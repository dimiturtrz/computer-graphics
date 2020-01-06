function [] = hw2()
    I = zeros(50,50);
    value = 50;
    ox = 20; oy = 30;
    a = 5; b = 10; h = 1;
    A = a*a; B = b*b;

    d = h*(h*B - A*(b - h/4));
    y = b;
    x = 0;

    while y >= (A/B)*x 
       I = fourSymetric(I, ox, oy, x, y, value);
       disp(1);
       disp(d);
       if (d < 0) %D
            d = d - B*h*(2*x - 3*h) + 2*A*h*(y+h);
            x = x + h;
            y = y - h;
       else %H
            d = d - B*h*(2*x - 3*h);
            x = x + h;
       end
    end
    
    while y >= 0
       disp(2);
       disp(d);
       I = fourSymetric(I, ox, oy, x, y, value);
       if (d < 0) %V
            d = d - A*h*(2*y - 3*h);
            y = y - h;
       else %D
            d = d - 2*B*h*(x - h) + A*h*(2*y + 3*h);
            x = x + h;
            y = y - h;
       end
    end

    image(I)
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