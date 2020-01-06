function [] = bc()
    I = zeros(50,50);
    value = 50;
    ox = 20; oy = 30;
    R = 15;

    h = 1;
    d = 2*h*(h - R);
    x = 0;
    y = R;

    while y >= x 
       I = eightSymetric(I, ox, oy, x, y, value);
       if d < 0 
           disp(d + h*y - h*h/2);
           if ((d + h*y - h*h/2) < 0) %H
                x = x + h;
                d = d + 2*h*x + 3*h*h;
           else %D
                x = x + h;
                y = y - h;
                d = d + 2*h*x - 2*y*h + 6*h*h;
           end
       else
           disp(d - h*x - h*h/2);
           if ((d - h*x - h*h/2) > 0) %V
                y = y - h;
                d = d - 2*y*h + 3*h*h;
           else %D
                x = x + h;
                y = y - h;
                d = d + 2*h*x - 2*y*h + 6*h*h;
           end
       end
    end

    image(I)
end

function newImage = eightSymetric(I, ox, oy, x, y, value)
    newImage = I;
    %I
    newImage(ox+x, oy+y) = value;
    newImage(ox+y, oy+x) = value;
    %II
    newImage(ox-x, oy+y) = value;
    newImage(ox-y, oy+x) = value;
    %III
    newImage(ox-x, oy-y) = value;
    newImage(ox-y, oy-x) = value;
    %IV
    newImage(ox+x, oy-y) = value;
    newImage(ox+y, oy-x) = value;
end