function [handles] = LeaveSide(handles)

try
    handles.bwcolorchosen = handles.Bluebwcolorchosen;
catch
    handles.bwcolorchosen = handles.colorchosen;
end

if handles.side == 3
    
    for ii = 1:length(handles.ycoordinates)
        handles.bwcolorchosen(ii,1:floor(handles.xcoordinates(ii))) = 0;
    end
       
elseif handles.side == 2
    
    for ii = 1:length(handles.ycoordinates)
        handles.bwcolorchosen(ii,floor(handles.xcoordinates(ii)):end) = 0;
    end

elseif handles.side == 5
    
    for ii = 1:length(handles.xcoordinates)
        handles.bwcolorchosen(1:floor(handles.ycoordinates(ii)),ii) = 0;
    end
    
elseif handles.side == 4
    
    for ii = 1:length(handles.xcoordinates)
        handles.bwcolorchosen(floor(handles.ycoordinates(ii)):end,ii) = 0;
    end
    
elseif handles.side == 6
    for ii = 1:size(handles.bwcolorchosen,1)
        if ii ~= min(floor(handles.ycoordinates)):max(floor(handles.ycoordinates))
            handles.bwcolorchosen(ii,:) = 0;
        else
            tmpy = find(ii == floor(handles.ycoordinates(:)));
            tmpx = handles.xcoordinates(tmpy);
            handles.bwcolorchosen(ii,1:min(tmpx)) = 0;
            handles.bwcolorchosen(ii,max(tmpx):end) = 0;
        end
    end
end
handles.Conbwcolorchosen = im2bw(handles.bwcolorchosen, 0.5);