function [] = hw3()

    D = 50;
    I = zeros(D, D);
    value = 50;
    
    [pointsX, pointsY] = ginput;
    [startX, startY] = ginput(1);

    x1 = round(D * pointsX(length(pointsX))); 
    y1 = round(D * (1-pointsY(length(pointsY))));
    for i = 1:length(pointsX)
       x2 = round(D * pointsX(i)); y2 = (round(D * (1 - pointsY(i))));
       I = plotLine(I, x1, y1, x2, y2, value);
       x1 = x2; y1 = y2;
    end
    
    x0 = round(D * startX); 
    y0 = round(D * (1-startY));
    I = simpleFloodFill(I, x0, y0, 0, value);
    
    image(transpose(I))
end

function newImage = simpleFloodFill(I, x, y, emptyValue, fullValue)
    newImage = I;
    
    if (I(x,y) == emptyValue)
        image(transpose(newImage));
        pause(0.005);
        
        newImage(x,y) = fullValue;
        newImage = simpleFloodFill(newImage, x-1, y, emptyValue, fullValue);
        newImage = simpleFloodFill(newImage, x+1, y, emptyValue, fullValue);
        newImage = simpleFloodFill(newImage, x, y-1, emptyValue, fullValue);
        newImage = simpleFloodFill(newImage, x, y+1, emptyValue, fullValue);
    end
end

function newImage = plotLine(I, x1, y1, x2, y2, value)

    newImage = I;

    dx = abs(x2-x1);
    dy = abs(y2-y1);

    reverse = (dy > dx);
    if(reverse)
        d=x1; x1=y1; y1=d;
        d=x2; x2=y2; y2=d;
        d=dx; dx=dy; dy=d;
    end

    incX = sign(x2-x1); %(x2>x1) ? 1 : -1
    incY = sign(y2-y1);

    % d0 = 2dy-dx
    p = 2*dy - dx;
    y = y1;
    for x = x1:incX:x2 
        if(reverse)
            newImage(y,x) = value;
        else 
            newImage(x,y) = value;
        end
        yDiff = max(sign(p), 0)*incY; %(p>0): incY:0;
        y = y + yDiff;
        p = p + 2*dy - 2*dx*abs(yDiff);
    end

end