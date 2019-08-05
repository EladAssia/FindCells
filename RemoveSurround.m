function [handles] = RemoveSurround(handles)

if handles.side == 2 || handles.side == 3
    handles.filteredimage(:,1:sqrt(handles.factor)) = 0;
    handles.filteredimage(:,size(handles.filteredimage,2)-sqrt(handles.factor):size(handles.filteredimage,2)) = 0;
    for ii = handles.ycoordinates(1):handles.ycoordinates(end-sqrt(handles.factor))
        tmp = find(handles.filteredimage(ii,:));
        if ~isempty(tmp)
            maxTmp = max(find(tmp<=sqrt(handles.factor)));
            minTmp = min(find(tmp+sqrt(handles.factor)>=size(handles.filteredimage,2)));
            if ~isempty(maxTmp)
                tmp = tmp(maxTmp+1:end);
            end
            if ~isempty(minTmp)
                tmp = tmp(1:minTmp-1);
            end
            for jj = 1:length(tmp)
                if sum(sum(handles.filteredimage(ii:ii+sqrt(handles.factor),tmp(jj)-sqrt(handles.factor):tmp(jj)+sqrt(handles.factor)))) > 1
                    handles.filteredimage(ii,tmp(jj)) = 0;
                end
            end
        end
    end
elseif handles.side == 4 || handles.side == 5
    handles.filteredimage(1:sqrt(handles.factor),:) = 0;
    handles.filteredimage(size(handles.filteredimage,2)-sqrt(handles.factor):size(handles.filteredimage,2),:) = 0;
    for ii = handles.xcoordinates(1):handles.xcoordinates(end-1)
        tmp = find(handles.filteredimage(:,ii));
        if ~isempty(tmp)
            maxTmp = max(find(tmp<=sqrt(handles.factor)));
            minTmp = min(find(tmp+sqrt(handles.factor)>=size(handles.filteredimage,2)));
            if ~isempty(maxTmp)
                tmp = tmp(maxTmp+1:end);
            end
            if ~isempty(minTmp)
                tmp = tmp(1:minTmp-1);
            end
            for jj = 1:length(tmp)
                if sum(sum(handles.filteredimage(tmp(jj)-sqrt(handles.factor):tmp(jj)+sqrt(handles.factor),ii:ii+sqrt(handles.factor)))) > 1
                    handles.filteredimage(ii,tmp(jj)) = 0;
                end
            end
        end
    end
elseif handles.side == 6
    for ii = min(handles.x):max(handles.x)
        for jj = min(handles.y):max(handles.y)
            if handles.filteredimage(jj,ii) ~= 0
                if (max(max(handles.filteredimage(jj,ii)==handles.filteredimage(jj+1:jj+sqrt(handles.factor),ii))) ~=0 || ...
                        max(max(handles.filteredimage(jj,ii)==handles.filteredimage(jj-sqrt(handles.factor):jj-1,ii))) ~=0 || ...
                        max(max(handles.filteredimage(jj,ii)==handles.filteredimage(jj,ii+1:ii+sqrt(handles.factor)))) ~=0 || ...
                        max(max(handles.filteredimage(jj,ii)==handles.filteredimage(jj,ii-sqrt(handles.factor):ii-1))) ~=0 || ...
                        max(max(handles.filteredimage(jj,ii)==handles.filteredimage(jj+1:jj+sqrt(handles.factor),ii+1:ii+sqrt(handles.factor)))) ~=0 || ...
                        max(max(handles.filteredimage(jj,ii)==handles.filteredimage(jj-sqrt(handles.factor):jj-1,ii+1:ii+sqrt(handles.factor)))) ~=0 || ...
                        max(max(handles.filteredimage(jj,ii)==handles.filteredimage(jj+1:jj+sqrt(handles.factor),ii-sqrt(handles.factor):ii-1))) ~=0 || ...
                        max(max(handles.filteredimage(jj,ii)==handles.filteredimage(jj-sqrt(handles.factor):jj-1,ii-sqrt(handles.factor):ii-1))) ~=0)
                    handles.filteredimage(jj,ii) = 0;
                end
            end
        end
    end
elseif handles.side == 7
    handles.filteredimage(:,1:sqrt(handles.factor)) = 0;
    handles.filteredimage(:,size(handles.filteredimage,2)-sqrt(handles.factor):size(handles.filteredimage,2)) = 0;
    for ii = 1:size(handles.filteredimage,1)-sqrt(handles.factor)
        tmp = find(handles.filteredimage(ii,:));
        if ~isempty(tmp)
            maxTmp = max(find(tmp<=sqrt(handles.factor)));
            minTmp = min(find(tmp+sqrt(handles.factor)>=size(handles.filteredimage,2)));
            if ~isempty(maxTmp)
                tmp = tmp(maxTmp+1:end);
            end
            if ~isempty(minTmp)
                tmp = tmp(1:minTmp-1);
            end
            for jj = 1:length(tmp)
                if sum(sum(handles.filteredimage(ii:ii+sqrt(handles.factor),tmp(jj)-sqrt(handles.factor):tmp(jj)+sqrt(handles.factor)))) > 1
                    handles.filteredimage(ii,tmp(jj)) = 0;
                end
            end
        end
    end
end