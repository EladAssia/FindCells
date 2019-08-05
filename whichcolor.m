function [x, y, colchosen, bwcolchosen] = whichcolor(pic, colorchosen)

if colorchosen == 'R'
    colchosen = pic(:,:,1);
    bwcolchosen = im2bw(colchosen);
    imshow(colchosen);
    [x,y] = ginput(100);
    
    
elseif colorchosen == 'G'
    colchosen = pic(:,:,2);
    bwcolchosen = im2bw(colchosen);
    imshow(colchosen);
    [x,y] = ginput(100);
else
    colchosen = pic(:,:,3);
    bwcolchosen = im2bw(colchosen);
    imshow(colchosen);
    [x,y] = ginput(100);
end

x = round(x);
y = round(y);
x(find(x <= 0)) = 1;
y(find(y <= 0)) = 1;
x(find(x > size(pic,2))) = size(pic,2);
y(find(y > size(pic,1))) = size(pic,1);