function [x, y] = waitForMousePress

set (gcf, 'WindowButtonMotionFcn', @mouseMoveAllImages);
clicked = waitforbuttonpress;
C = get (gca, 'CurrentPoint');
x = C(1,1);
y = C(2,2);
set (gcf, 'WindowButtonMotionFcn', @mouseMove);
sofData = get(gcf,'Children');
for ii = 4:7
    imdata = sofData(ii);
    if size(imdata.Children,1) > 1
        delete(imdata.Children(1:end-1));
    end
end