function [handles] = RemoveArea(handles)

questdlg('Please circle the area and press enter', '', 'OK', 'OK');
[x,y] = showginput(100);
lines = get(handles.OriginalImage, 'Children');
delete(lines(1:end-1));
lines = get(handles.RGB, 'Children');
delete(lines(1:end-1));
lines = get(handles.Added, 'Children');
delete(lines(1:end-1));
lines = get(handles.Filtered, 'Children');
delete(lines(1:end-1));


x(end+1) = x(1);
y(end+1) = y(1);
x = round(x);
y = round(y);

haddedRGB = plot(x, y, 'Parent', handles.RGB);
haddedFil = plot(x, y, 'Parent', handles.Filtered);
haddedOrg = plot(x, y, 'Parent', handles.OriginalImage);
haddedAdd = plot(x, y, 'Parent', handles.Added);
correct = questdlg('Is this correct?', 'Circle the cell', 'Yes','No','No');
if strcmp(correct, 'Yes')
    tmpX = handles.x;
    tmpY = handles.y;
    tmpXcoordinates = handles.xcoordinates;
    tmpYycoordinates = handles.ycoordinates;
    handles.x = x;
    handles.y = y;
    [area, handles] = Circular(handles);
    for ii = 1:size(handles.bwcolorchosen,1)
        tmpy = find(ii == floor(handles.ycoordinates(:)));
        tmpx = handles.xcoordinates(tmpy);
        handles.addedcells(ii,min(tmpx):max(tmpx)) = 0;
    end
    handles.x = tmpX;
    handles.y = tmpY;
    handles.xcoordinates = tmpXcoordinates;
    handles.ycoordinates = tmpYycoordinates;
end

delete(haddedRGB);
delete(haddedFil);
delete(haddedOrg);
delete(haddedAdd);