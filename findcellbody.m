%% Iteration
close all
clear
originalpic = imread('C:\users\Elad\Pictures\Picture1.png');
colchosen = input('Please choose a color (R/G/B) ', 's');
[x,y, colorchosen, bwcolorchosen] = whichcolor(originalpic, colchosen);
side = input('Which side should be taken off? (L/R/U/D) ', 's');

%% Bulding coordinates
if side == 'R' || side == 'L'
    ycoordinates = 1:size(originalpic,1);
    try 
        xcoordinates = x(1);
    catch
    end
    try
        if y(end) < size(originalpic,1)
        y(end+1) = size(originalpic,1);
        x(end+1) = x(end);
        end
    catch
    end
        
    for ii = 1:(length(y)-1)
        diffx = x(ii+1)-x(ii);
        diffy = y(ii+1)-y(ii);
        for jj = y(ii):y(ii+1)
            xcoordinates(jj+1) = xcoordinates(jj) + diffx/diffy;
        end
    end
    try
        xcoordinates = xcoordinates(1:size(ycoordinates,2));
    catch
        xcoordinates = 0;
        ycoordinates = 0;
    end
    
elseif side == 'U' || side == 'D'
    
    try
        ycoordinates = y(1);
    catch
    end
    xcoordinates = 1:size(originalpic,2);
    try
        if x(end) < size(originalpic,2)
        x(end+1) = size(originalpic,2);
        y(end+1) = y(end);
        end
    catch
    end
        
    for ii = 1:(length(x)-1)
        diffx = x(ii+1)-x(ii);
        diffy = y(ii+1)-y(ii);
        for jj = x(ii):x(ii+1)
            ycoordinates(jj+1) = ycoordinates(jj) + diffy/diffx;
        end
    end
    
    try
        ycoordinates = ycoordinates(1:size(xcoordinates,2));
    catch
        ycoordinates = 0;
        xcoordinates = 0;
    end
end

%%
numofcells = countingcells(colorchosen, bwcolorchosen, side, xcoordinates, ycoordinates);

%%



