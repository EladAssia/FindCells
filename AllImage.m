function [area, handles] = AllImage(handles)
area = 0;
if ~isempty(handles.x)
    ycoordinates = 1:size(handles.Original,1);
    try
        xcoordinates = handles.x(1);
    catch
    end
    try
        if handles.y(end) < size(handles.Original,1)
            handles.y(end+1) = size(handles.Original,1);
            handles.x(end+1) = handles.x(end);
        end
    catch
    end
    
    jj = 1;
    for ii = 1:(length(handles.y)-1)
        diffx = handles.x(ii+1)-handles.x(ii);
        diffy = handles.y(ii+1)-handles.y(ii);
        while jj < handles.y(ii+1)
            xcoordinates(jj+1) = xcoordinates(jj) + diffx/diffy;
            jj = jj + 1;
        end
    end
    try
        xcoordinates = xcoordinates(1:size(ycoordinates,2));
    catch
        xcoordinates = 0;
        ycoordinates = 0;
    end
    
    handles.xcoordinates = xcoordinates;
    handles.ycoordinates = ycoordinates;
    for ii = 1:length(handles.xcoordinates)
        if handles.side == 3
            area = area + length(round(handles.xcoordinates(ii)):size(handles.colorchosen,2));
        else
            area = area + length(1:round(handles.xcoordinates(ii))-1);
        end
    end
else
    area = size(handles.Original,1)*size(handles.Original,2);
    handles.xcoordinates = 1:size(handles.Original,2);
    handles.ycoordinates = 1:size(handles.Original,1);
end