function [handles] = MakeCoordinatesCorrection(handles, x, y)

x = round(x);
y = round(y);
x(find(x <= 0)) = 1;
y(find(y <= 0)) = 1;
x(find(x > size(handles.Original,2))) = size(handles.Original,2);
y(find(y > size(handles.Original,1))) = size(handles.Original,1);
handles.x = x;
handles.y = y;