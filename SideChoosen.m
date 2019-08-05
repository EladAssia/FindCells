function [area, handles] = SideChoosen(handles)

if handles.side == 2 || handles.side == 3
    [area, handles] = LeftRight(handles);
elseif handles.side == 4 || handles.side == 5
    [area, handles] = UpDown(handles);
elseif handles.side == 6
    [area, handles] = Circular(handles);
elseif handles.side == 7
    [area, handles] = AllImage(handles);
end