function [area, handles] = Circular(handles)
area = 0;
try
    xcoordinates = handles.x(1);
    ycoordinates = handles.y(1);
    handles.x(end+1) = handles.x(1);
    handles.y(end+1) = handles.y(1);
catch
end
if ~isempty(handles.x)
    jj = 1;
    for ii = 1:length(handles.x)-1
        if abs(handles.x(ii+1)-handles.x(ii))<=abs(handles.y(ii+1)-handles.y(ii))
            diffx = handles.x(ii+1)-handles.x(ii);
            diffy = handles.y(ii+1)-handles.y(ii);
            if handles.x(ii) <= handles.x(ii+1)
                diffx = abs(diffx);
                diffy = abs(diffy);
            else
                diffx = -abs(diffx);
                diffy = abs(diffy);
            end
            if single(xcoordinates(jj)) ~= single(handles.x(ii+1))
                while single(xcoordinates(jj)) ~= single(handles.x(ii+1))
                    xcoordinates(jj+1) = xcoordinates(jj) + diffx/diffy;
                    jj = jj + 1;
                end
                if handles.y(ii)< handles.y(ii+1)
                    ycoordinates(end:length(xcoordinates)) = handles.y(ii):handles.y(ii+1);
                else
                    ycoordinates(end:length(xcoordinates)) = handles.y(ii):-1:handles.y(ii+1);
                end
            else
                xcoordinates(jj:jj+diffy) = xcoordinates(jj);
                jj = jj + diffy;
                if handles.y(ii)< handles.y(ii+1)
                    ycoordinates(end:length(xcoordinates)) = handles.y(ii):handles.y(ii+1);
                else
                    ycoordinates(end:length(xcoordinates)) = handles.y(ii):-1:handles.y(ii+1);
                end
            end
            
        else
            diffx = handles.x(ii+1)-handles.x(ii);
            diffy = handles.y(ii+1)-handles.y(ii);
            if handles.y(ii) <= handles.y(ii+1)
                diffx = abs(diffx);
                diffy = abs(diffy);
            else
                diffx = -abs(diffx);
                diffy = abs(diffy);
            end
            if single(ycoordinates(jj)) ~= single(handles.y(ii+1))
                while single(ycoordinates(jj)) ~= single(handles.y(ii+1))
                    ycoordinates(jj+1) = ycoordinates(jj) + diffy/diffx;
                    jj = jj + 1;
                end
                if handles.x(ii)< handles.x(ii+1)
                    xcoordinates(end:length(ycoordinates)) = handles.x(ii):handles.x(ii+1);
                else
                    xcoordinates(end:length(ycoordinates)) = handles.x(ii):-1:handles.x(ii+1);
                end
            else
                ycoordinates(jj:jj+diffx) = ycoordinates(jj);
                jj = jj + diffx;
                if handles.x(ii)< handles.x(ii+1)
                    xcoordinates(end:length(ycoordinates)) = handles.x(ii):handles.x(ii+1);
                else
                    xcoordinates(end:length(ycoordinates)) = handles.x(ii):-1:handles.x(ii+1);
                end
            end
        end
        for kk = 1:length(xcoordinates)
            a = find(single(ycoordinates) == single(ycoordinates(kk)));
            if length(a) > 1
                area = area + abs(xcoordinates(a(2))-xcoordinates(a(1)));
            end
        end
        area = area/2;
        handles.xcoordinates = xcoordinates;
        handles.ycoordinates = ycoordinates;
    end
else
    area = size(handles.Original,1)*size(handles.Original,2);
    handles.xcoordinates = 1:size(handles.Original,2);
    handles.ycoordinates = 1:size(handles.Original,1);
end

