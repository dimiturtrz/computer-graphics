function [] = hw4()

    D = 50;
    I = zeros(D, D);
    value1 = 50;
    value2 = 25;

    x1 = 26; y1 = 42;
    x2 = 35; y2 = 5;
    xL = 15; xR = D-10; yB = 15; yT = D-10;
    
    I = plotLine(I, xL, yB, xL, yT, value1);
    I = plotLine(I, xL, yT, xR, yT, value1);
    I = plotLine(I, xR, yT, xR, yB, value1);
    I = plotLine(I, xR, yB, xL, yB, value1);
    I = plotLine(I, x1, y1, x2, y2, value2);
    image(transpose(I));
    
    ti=0; t0=1; dx=x2-x1;
    visible = false;
    [ti, t0, visible] = clipt(-dx, x1-xL, ti, t0);
    if(visible)
        [ti, t0, visible] = clipt(dx, xR-x1, ti, t0);
        if(visible)
           dy = y2-y1;
           [ti, t0, visible] = clipt(-dy, y1-yB, ti, t0);
           if(visible)
              [ti, t0, visible] = clipt(dy, yT-y1, ti, t0);
              if(visible)
                  if(t0 < 1)
                      x2 = round(x1 + t0*dx);
                      y2 = round(y1 + t0*dy);
                  end
                  if(ti > 0)
                     x1 = round(x1 + ti*dx);
                     y1 = round(y1 + ti*dy);
                  end
                  I = plotLine(I, x1, y1, x2, y2, value1);
                  image(transpose(I));
              end
           end
        end
    end
end

function [ti, t0, visible] = clipt(d, q, ti, t0)
    visible = true;
    if ((d == 0) && (q < 0))
        visible = false;
    else if (d < 0)
            t = q/d;
            if (t > t0)
                visible = false;
            else if (t > ti)
                    ti = t;
                end
            end
        else if (d > 0)
                t = q/d;
                if (t < t0)
                    t0 = t;
                end
            end
        end
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