function [handles] = MakeCells(handles)

[handles.cellx, handles.celly] = find(handles.filteredimage);
if max(size(handles.Original))
    for ii = 1:length(handles.cellx)
        handles.filteredimage(handles.cellx(ii):handles.cellx(ii)+sqrt(handles.factor)-1,handles.celly(ii):handles.celly(ii)+sqrt(handles.factor)-1) = 250;
    end
end