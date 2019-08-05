function [handles] = findTheOverlappingCells(handles)

if any(strcmp('redcellspos',fieldnames(handles))) && any(strcmp('greencellspos',fieldnames(handles)))
    figure('units','normalized','outerposition',[0 0 1 1])
    myim = [handles.redfinal, 200*ones(size(handles.redfinal,1),20), handles.greenfinal];
    imshow(myim)
    title('Overlap between Red and Green Cells')
    hold on
    numOverlappingCellsRG = 0;
    kk = 1;
    for ii = 1:handles.factor:size(handles.redcellspos,1)-handles.factor
        for jj = 1:handles.factor:size(handles.greencellspos,1)-handles.factor
            [overlap, pos] = isSameCell(handles, ii, jj, handles.redcellspos, handles.greencellspos);
            if overlap
                numOverlappingCellsRG = numOverlappingCellsRG + 1;
                plot(handles.redcellspos(pos,1), handles.redcellspos(pos,2), '*')
                plot(handles.redcellspos(pos,1) + size(handles.Original,2) + 20, handles.redcellspos(pos,2), '*')
                posOverlappingCellsRG(kk,:) = handles.redcellspos(pos,:);
                kk = kk + 1;
            end
        end
    end
    handles.numOverlappingCellsRG = numOverlappingCellsRG;
    handles.posOverlappingCellsRG = posOverlappingCellsRG;
    [handles] = CircleCells(handles, 'No', 'RG');
    set(handles.OverlapRG, 'String', ['Red and Green overlap: ', num2str(numOverlappingCellsRG)]);
end

if any(strcmp('redcellspos',fieldnames(handles))) && any(strcmp('bluecellspos',fieldnames(handles)))
    figure('units','normalized','outerposition',[0 0 1 1])
    myim = [handles.redfinal, 200*ones(size(handles.redfinal,1),20), handles.bluefinal];
    imshow(myim)
    title('Overlap between Red and Blue Cells')
    hold on
    numOverlappingCellsRB = 0;
    kk = 1;
    for ii = 1:handles.factor:size(handles.redcellspos,1)-handles.factor
        for jj = 1:handles.factor:size(handles.bluecellspos,1)-handles.factor
            [overlap, pos] = isSameCell(handles, ii, jj, handles.redcellspos, handles.bluecellspos);
            if overlap
                numOverlappingCellsRB = numOverlappingCellsRB + 1;
                plot(handles.redcellspos(pos,1), handles.redcellspos(pos,2), '*')
                plot(handles.redcellspos(pos,1) + size(handles.Original,2) + 20, handles.redcellspos(pos,2), '*')
                posOverlappingCellsRB(kk,:) = handles.redcellspos(pos,:);
                kk = kk + 1;
            end
        end
    end
    handles.numOverlappingCellsRB = numOverlappingCellsRB;
    handles.posOverlappingCellsRB = posOverlappingCellsRB;
    [handles] = CircleCells(handles, 'No', 'RB');
    set(handles.OverlapRB, 'String', ['Red and Blue overlap: ', num2str(numOverlappingCellsRB)]);
end

if any(strcmp('greencellspos',fieldnames(handles))) && any(strcmp('bluecellspos',fieldnames(handles)))
    figure('units','normalized','outerposition',[0 0 1 1])
    myim = [handles.greenfinal, 200*ones(size(handles.redfinal,1),20), handles.bluefinal];
    imshow(myim)
    title('Overlap between Green and Blue Cells')
    hold on
    numOverlappingCellsGB = 0;
    kk = 1;
    for ii = 1:handles.factor:size(handles.greencellspos,1)-handles.factor
        for jj = 1:handles.factor:size(handles.bluecellspos,1)-handles.factor
            [overlap, pos] = isSameCell(handles, ii, jj, handles.greencellspos, handles.bluecellspos);
            if overlap
                numOverlappingCellsGB = numOverlappingCellsGB + 1;
                plot(handles.greencellspos(pos,1), handles.greencellspos(pos,2), '*')
                plot(handles.greencellspos(pos,1) + size(handles.Original,2) + 20, handles.greencellspos(pos,2), '*')
                posOverlappingCellsGB(kk,:) = handles.greencellspos(pos,:);
                kk = kk + 1;
            end
        end
    end
    handles.numOverlappingCellsGB = numOverlappingCellsGB;
    handles.posOverlappingCellsGB = posOverlappingCellsGB;
    [handles] = CircleCells(handles, 'No', 'GB');
    set(handles.OverlapGB, 'String', ['Green and Blue overlap: ', num2str(numOverlappingCellsGB)]);
end