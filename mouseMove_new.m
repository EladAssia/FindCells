function mouseMove (object, eventdata)


imdata = get(gca,'Children');
if size(imdata,1) > 1
    for ii = 1:length(imdata)-1
        if strcmp(imdata(ii).Marker, '.')
            delete(imdata(ii));
        end
    end
end

if size(imdata,3) == 1
    C = get (gca, 'CurrentPoint');
    imsizex = get(gca,'XLim');
    imsizey = get(gca,'YLim');
    oneim = imsizex(2)-imsizex(1);
    hold on
    if (oneim-20)/20000 > 1
        factor = 50;
    elseif (oneim-20)/2000 > 1
        factor = 25;
    else
        factor = 10;
    end
    if C(1,1) > (oneim-20)/2
        h1 = plot((C(1,1)-oneim/2-10), (C(2,2)-factor):(C(2,2)+factor), '.w');
        h2 = plot((C(1,1)), (C(2,2)-factor):(C(2,2)+factor), '.w');
        h3 = plot((C(1,1)-oneim/2-10-factor):(C(1,1)-oneim/2+factor-10), C(2,2), '.w');
        h4 = plot((C(1,1)-factor):(C(1,1)+factor), C(2,2), '.w');
    else
        h1 = plot((C(1,1)+oneim/2+10), (C(2,2)-factor):(C(2,2)+factor), '.w');
        h2 = plot((C(1,1)), (C(2,2)-factor):(C(2,2)+factor), '.w');
        h3 = plot((C(1,1)+oneim/2-factor+10):(C(1,1)+oneim/2+factor+10), C(2,2), '.w');
        h4 = plot((C(1,1)-factor):(C(1,1)+factor), C(2,2), '.w');
    end
end


%title(gca, ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);