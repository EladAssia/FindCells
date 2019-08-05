function [handles] = myHeatmap(handles)

Grid = get(handles.Grid, 'value');
Sigma = get(handles.SD, 'value');

tt = 1;
pp = 1;
for ii = 1:5*handles.factor:size(handles.addedcells,1)-5*handles.factor
    for jj = 1:5*handles.factor:size(handles.addedcells,2)-5*handles.factor
        k(tt,pp) = length(find(handles.addedcells(ii:ii+5*handles.factor-1, jj:jj+5*handles.factor-1)))/sqrt(handles.factor);
        tt = tt+1;
    end
    pp = pp + 1;
    tt = 1;
end
k = k';
handles.heatMap = conv2(k,gaussian2d(Grid,Sigma),'same');