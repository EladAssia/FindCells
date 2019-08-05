function [area, handles] = UpDown(handles)
area = 0;
if ~isempty(handles.x)
    try
        ycoordinates = handles.y(1);
    catch
    end
    xcoordinates = 1:size(handles.Original,2);
    try
        if handles.x(end) < size(handles.Original,2)
            handles.x(end+1) = size(handles.Original,2);
            handles.y(end+1) = handles.y(end);
        end
    catch
    end
    
    jj = 1;
    for ii = 1:(length(handles.x)-1)
        diffx = handles.x(ii+1)-handles.x(ii);
        diffy = handles.y(ii+1)-handles.y(ii);
        while jj < handles.x(ii+1)
            ycoordinates(jj+1) = ycoordinates(jj) + diffy/diffx;
            jj = jj + 1;
        end
    end
    
    try
        ycoordinates = ycoordinates(1:size(xcoordinates,2));
    catch
        ycoordinates = 0;
        xcoordinates = 0;
    end
    
    handles.xcoordinates = xcoordinates;
    handles.ycoordinates = ycoordinates;
    for ii = 1:length(handles.ycoordinates)
        if handles.side == 4
            area = area + length(round(handles.ycoordinates(ii)):size(handles.colorchosen,1));
        else
            area = area + length(1:round(handles.ycoordinates(ii))-1);
        end
    end
else
    area = size(handles.Original,1)*size(handles.Original,2);
    handles.xcoordinates = 1:size(handles.Original,1);
    handles.ycoordinates = 1:size(handles.Original,2);
end
