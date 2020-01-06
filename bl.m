I = zeros(50,50);
value = 50;

    %40    23    10    12
    %10    12    26    42
    %26    42    40    23

x1 = 26; y1 = 42;
x2 = 40; y2 = 23;

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
        I(y,x) = value;
    else 
        I(x,y) = value;
    end
    yDiff = max(sign(p), 0)*incY; %(p>0): incY:0;
    disp([x, y, yDiff, p])
    y = y + yDiff;
    p = p + 2*dy - 2*dx*abs(yDiff);
end

image(I)