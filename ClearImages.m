function ClearImages(handles)

imdata = get(handles.Added,'Children');
if size(imdata,1) > 1
    delete(imdata(1:end-2));
end

imdata = get(handles.RGB,'Children');
if size(imdata,1) > 1
    delete(imdata(1:end-1));
end

imdata = get(handles.OriginalImage,'Children');
if size(imdata,1) > 1
    delete(imdata(1:end-1));
end