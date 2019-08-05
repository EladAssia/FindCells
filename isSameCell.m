function [overlap, pos] = isSameCell(handles, ii, jj, color1, color2)

overlap = false;
pos = 0;
for kk = 0:handles.factor-1
    for ss = 0:handles.factor-1
        if color1(ii+kk,1) == color2(jj+ss,1) && ...
                color1(ii+kk,2) == color2(jj+ss,2)
            overlap = true;
            pos = ii+kk;
        end
    end
end