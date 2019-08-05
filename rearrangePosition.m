function [handles] = rearrangePosition(handles)

for ii = 1:handles.factor:size(handles.redcellspos,1)-handles.factor
    for jj = 0:sqrt(handles.factor):handles.factor-sqrt(handles.factor)-1
        if handles.redcellspos(ii+jj,1) + 1 ~= handles.redcellspos(ii+jj+sqrt(handles.factor),1) || ...
                handles.redcellspos(ii+jj,2) ~= handles.redcellspos(ii+jj+sqrt(handles.factor),2)
            next = find(handles.redcellspos(ii+jj,2) == handles.redcellspos(ii+jj+1:end,2));
            kk = 1;
            while ~isempty(next)
                if handles.redcellspos(ii+jj,2) == handles.redcellspos(ii+jj+next(kk),2)
                    tmp1 = [handles.redcellspos(ii+jj+sqrt(handles.factor):ii+jj+next(kk)-1,:)];
                    try
                        tmp2 = [handles.redcellspos(ii+jj+next(kk):ii+jj+next(kk)+sqrt(handles.factor)-1,:)];
                    catch
                        p = 90;
                    end
                    handles.redcellspos(ii+jj+sqrt(handles.factor):ii+jj+2*sqrt(handles.factor)-1,:) = tmp2;
                    handles.redcellspos(ii+jj+2*sqrt(handles.factor):ii+jj+2*sqrt(handles.factor)+size(tmp1,1)-1,:) = tmp1;
                    next = [];
                end
                kk = kk + 1;
            end
        end
    end
end
