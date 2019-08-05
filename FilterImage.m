function [handles, newpic] = FilterImage(handles)

newpic = handles.bwcolorchosen;
fig = figure;
set(fig,'units','normalized','outerposition',[0 0 1 1]);
subplot(2,2,1);
imshow(handles.colorchosen);
title('Not Filtered')

for ii = 0:2
    se = strel('disk', ii*2);
    rodepic = imerode(newpic, se);
    subplot(2,2,ii+2)
    imshow(rodepic);
    title(['Option ', num2str(ii+1)])
end
option = str2double(questdlg('Which figure filtered the best?', '', '1', '2', '3', '3'));
close
fig = figure;
set(fig,'units','normalized','outerposition',[0 0 1 1]);
subplot(2,2,1);
imshow(handles.colorchosen);
title('Not Filtered')

if option == 3
    option = 4;
end

for ii = -1:1
    se = strel('disk', option+ii);
    rodepic = imerode(newpic, se);
    subplot(2,2,ii+3)
    imshow(rodepic);
    title(['Option ', num2str(ii+2)])
end

if option == 1
    option = str2double(questdlg('Which figure filtered the best?', '', '1', '2', '3', '3'))-1;   
elseif option == 2
    option = str2double(questdlg('Which figure filtered the best?', '', '1', '2', '3', '3')); 
else
    option = str2double(questdlg('Which figure filtered the best?', '', '1', '2', '3', '3'))+2; 
end
close
se = strel('disk', option);
handles.bwcolorchosen = imerode(newpic, se);