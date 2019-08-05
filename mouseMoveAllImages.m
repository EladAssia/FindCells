function mouseMoveAllImages (object, eventdata)


sofData = get(gcf,'Children');
for ii = 4:7
    imdata = sofData(ii);
    if size(imdata.Children,1) > 1
        delete(imdata.Children(1:end-1));
    end
end

C = get (gca, 'CurrentPoint');
oneim = max(size(imdata(end)));
hold on
if (oneim)/20000 > 1
    factor = 50;
elseif (oneim-20)/2000 > 1
    factor = 25;
else
    factor = 10;
end
for ii = 4:7
    imdata = sofData(ii);
    plot((C(1,1)), (C(2,2)-factor):(C(2,2)+factor), '.w', 'Parent', imdata);
    plot((C(1,1)-factor):(C(1,1)+factor), C(2,2), '.w', 'Parent', imdata);
end


%title(gca, ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);