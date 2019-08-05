function [handles] = SubCells(handles)

questdlg('Please click on one of the cells', '', 'OK', 'OK');
[x, y] = waitForMousePress;

lines = get(handles.OriginalImage, 'Children');
delete(lines(1:end-1));
haddedRGB = plot(x,y, '*b', 'Parent', handles.RGB);
haddedFil = plot(x,y, '*b', 'Parent', handles.Filtered);
haddedOrg = plot(x,y, '*b', 'Parent', handles.OriginalImage);
haddedAdd = plot(x,y, '*b', 'Parent', handles.Added);

correct = questdlg('Is this correct?', 'Circle the cell', 'Yes','No','No');
if strcmp(correct, 'Yes')
    handles.addedcells(y-sqrt(handles.factor):y+sqrt(handles.factor),x-sqrt(handles.factor):x+sqrt(handles.factor)) = 0;
end
delete(haddedRGB);
delete(haddedFil);
delete(haddedOrg);
delete(haddedAdd);

