function [handles] = CircleCells(handles, allCells, Col)


ClearImages(handles)
if strcmp(allCells, 'Yes')
    cellx = handles.cellx;
    celly = handles.celly;
else
    if strcmp(Col, 'RG')
        celly = handles.posOverlappingCellsRG(:,1);
        cellx = handles.posOverlappingCellsRG(:,2);
        imshow(handles.Original(:,:,1),'Parent',handles.RGB)
        imshow(handles.Original(:,:,2),'Parent',handles.Added)
    elseif strcmp(Col, 'RB')
        celly = handles.posOverlappingCellsRB(:,1);
        cellx = handles.posOverlappingCellsRB(:,2);
        imshow(handles.Original(:,:,1),'Parent',handles.RGB)
        imshow(handles.Original(:,:,3),'Parent',handles.Added)
    else
        celly = handles.posOverlappingCellsGB(:,1);
        cellx = handles.posOverlappingCellsGB(:,2);
        imshow(handles.Original(:,:,2),'Parent',handles.RGB)
        imshow(handles.Original(:,:,3),'Parent',handles.Added)
    end
end

for ii = 1:length(cellx)
    if max(size(handles.Original))/10000 > 1
        tmp1y = [celly(ii)-20:1:celly(ii):1:celly(ii)+20];
        tmp2y = [celly(ii)+20:-1:celly(ii):-1:celly(ii)-20];
        tmpy = [tmp1y, tmp2y(2:end)];
        tmp1x = [cellx(ii):1:cellx(ii)+20];
        tmp2x = [cellx(ii)+20:-1:cellx(ii):-1:cellx(ii)-20];
        tmp3x = [cellx(ii)-20:1:cellx(ii)];
        tmpx = [tmp1x, tmp2x(2:end), tmp3x(2:end)];
        totcircle = [tmpy;tmpx];
        plot(totcircle(1,:),totcircle(2,:), 'parent', handles.Added)
        plot(totcircle(1,:),totcircle(2,:), 'parent', handles.RGB)
    elseif max(size(handles.Original))/1000 > 1
        tmp1y = [celly(ii)-12:1:celly(ii):1:celly(ii)+12];
        tmp2y = [celly(ii)+12:-1:celly(ii):-1:celly(ii)-12];
        tmpy = [tmp1y, tmp2y(2:end)];
        tmp1x = [cellx(ii):1:cellx(ii)+12];
        tmp2x = [cellx(ii)+12:-1:cellx(ii):-1:cellx(ii)-12];
        tmp3x = [cellx(ii)-12:1:cellx(ii)];
        tmpx = [tmp1x, tmp2x(2:end), tmp3x(2:end)];
        totcircle = [tmpy;tmpx];
        plot(totcircle(1,:),totcircle(2,:), 'parent', handles.Added)
        plot(totcircle(1,:),totcircle(2,:), 'parent', handles.RGB)
        plot(totcircle(1,:),totcircle(2,:), 'parent', handles.OriginalImage, 'linewidth', 2)
    else
        tmp1y = [celly(ii)-4:0.01:celly(ii):0.01:celly(ii)+4];
        tmp2y = [celly(ii)+4:-0.01:celly(ii):-0.01:celly(ii)-4];
        tmpy = [tmp1y, tmp2y(2:end)];
        tmp1x = [cellx(ii):0.01:cellx(ii)+4];
        tmp2x = [cellx(ii)+4:-0.01:cellx(ii):-0.01:cellx(ii)-4];
        tmp3x = [cellx(ii)-4:0.01:cellx(ii)];
        tmpx = [tmp1x, tmp2x(2:end), tmp3x(2:end)];
        totcircle = [tmpy;tmpx];
        plot(totcircle(1,:),totcircle(2,:), 'parent', handles.Added)
        plot(totcircle(1,:),totcircle(2,:), 'parent', handles.RGB)
        plot(totcircle(1,:),totcircle(2,:), 'parent', handles.OriginalImage, 'linewidth', 2)
    end
end