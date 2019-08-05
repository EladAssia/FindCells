function [handles] = AddCells(handles)


%set (gcf, 'WindowButtonMotionFcn', @mouseMoveAllImages);
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
    handles.addedcells(y:y+sqrt(handles.factor)-1,x:x-1+sqrt(handles.factor)) = 250;
end
delete(haddedRGB);
delete(haddedFil);
delete(haddedOrg);
delete(haddedAdd);