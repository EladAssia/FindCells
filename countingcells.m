function [numofcells] = countingcells(pic, bwpic, side, xcoordinates, ycoordinates)

[ypic,xpic] = find(bwpic~=0);
hold on
if side == 'L'
    for ii = 1:length(ycoordinates)
        tmp1 = find(ycoordinates(ii) == ypic);
        if tmp1
            tmp2 = find(xpic(tmp1) <= xcoordinates(ii));
            if tmp2
                xpic(tmp1(tmp2)) = 0;
                ypic(tmp1(tmp2)) = 0;
            end
        end
    end
    
    jj = 1;
    for ii = 1:length(xpic)
        if xpic(ii) ~= 0
            newxred(jj) = xpic(ii);
            newyred(jj) = ypic(ii);
            jj = jj + 1 ;
        end
    end
    
    pic = zeros(size(pic,1),size(pic,2));
    for ii = 1:length(newxred)
        pic(newyred(ii), newxred(ii)) = 250;
    end
    
    newpic = pic;
    for ii = 2:(size(pic,1)-1)
        for jj = 2:(size(pic,2)-1)
            if ((newpic(ii,jj) == newpic(ii+1,jj)) ||  (newpic(ii,jj) == newpic(ii-1,jj)) ||  (newpic(ii,jj) == newpic(ii,jj+1)) ||  (newpic(ii,jj) == newpic(ii,jj-1)) ||  (newpic(ii,jj) == newpic(ii+1,jj+1)) ||  (newpic(ii,jj) == newpic(ii-1,jj+1)) ||  (newpic(ii,jj) == newpic(ii+1,jj-1)) ||  (newpic(ii,jj) == newpic(ii-1,jj-1)))
                newpic(ii,jj) = 0;
            end
        end
    end
    %plot(xpic,ypic,'*')

elseif side == 'R'
    for ii = 1:length(ycoordinates)
        tmp1 = find(ycoordinates(ii) == ypic);
        if tmp1
            tmp2 = find(xpic(tmp1) >= xcoordinates(ii));
            if tmp2
                xpic(tmp1(tmp2)) = 0;
            end
        end
    end
    jj = 1;
    for ii = 1:length(xpic)
        if xpic(ii) ~= 0
            newxred(jj) = xpic(ii);
            newyred(jj) = ypic(ii);
            jj = jj + 1 ;
        end
    end
    
        pic = zeros(size(pic,1),size(pic,2));
    for ii = 1:length(newxred)
        pic(newyred(ii), newxred(ii)) = 250;
    end
    
    newpic = pic;
    for ii = 2:(size(pic,1)-1)
        for jj = 2:(size(pic,2)-1)
            if ((newpic(ii,jj) == newpic(ii+1,jj)) ||  (newpic(ii,jj) == newpic(ii-1,jj)) ||  (newpic(ii,jj) == newpic(ii,jj+1)) ||  (newpic(ii,jj) == newpic(ii,jj-1)) ||  (newpic(ii,jj) == newpic(ii+1,jj+1)) ||  (newpic(ii,jj) == newpic(ii-1,jj+1)) ||  (newpic(ii,jj) == newpic(ii+1,jj-1)) ||  (newpic(ii,jj) == newpic(ii-1,jj-1)))
                newpic(ii,jj) = 0;
            end
        end
    end
    
    plot(xpic,ypic,'*')

elseif side == 'U'
    for ii = 1:length(xcoordinates)
        tmp1 = find(xcoordinates(ii) == xpic);
        if tmp1
            tmp2 = find(ypic(tmp1) >= ycoordinates(ii));
            if tmp2
                ypic(tmp1(tmp2)) = 0;
            end
        end
    end
    jj = 1;
    for ii = 1:length(ypic)
        if ypic(ii) ~= 0
            newxred(jj) = xpic(ii);
            newyred(jj) = ypic(ii);
            jj = jj + 1 ;
        end
    end
    
    pic = zeros(size(pic,1),size(pic,2));
    for ii = 1:length(newxred)
        pic(newyred(ii), newxred(ii)) = 250;
    end
    
    newpic = pic;
    for ii = 2:(size(pic,1)-1)
        for jj = 2:(size(pic,2)-1)
            if ((newpic(ii,jj) == newpic(ii+1,jj)) ||  (newpic(ii,jj) == newpic(ii-1,jj)) ||  (newpic(ii,jj) == newpic(ii,jj+1)) ||  (newpic(ii,jj) == newpic(ii,jj-1)) ||  (newpic(ii,jj) == newpic(ii+1,jj+1)) ||  (newpic(ii,jj) == newpic(ii-1,jj+1)) ||  (newpic(ii,jj) == newpic(ii+1,jj-1)) ||  (newpic(ii,jj) == newpic(ii-1,jj-1)))
                newpic(ii,jj) = 0;
            end
        end
    end
    
    plot(xpic,ypic,'*')

elseif side == 'D'
    for ii = 1:length(xcoordinates)
        tmp1 = find(xcoordinates(ii) == xpic);
        if tmp1
            tmp2 = find(ypic(tmp1) <= ycoordinates(ii));
            if tmp2
                ypic(tmp1(tmp2)) = 0;
            end
        end
    end
    jj = 1;
    for ii = 1:length(ypic)
        if ypic(ii) ~= 0
            newxred(jj) = xpic(ii);
            newyred(jj) = ypic(ii);
            jj = jj + 1 ;
        end
    end
    
    pic = zeros(size(pic,1),size(pic,2));
    for ii = 1:length(newxred)
        pic(newyred(ii), newxred(ii)) = 250;
    end
    
    newpic = pic;
    for ii = 2:(size(pic,1)-1)
        for jj = 2:(size(pic,2)-1)
            if ((newpic(ii,jj) == newpic(ii+1,jj)) ||  (newpic(ii,jj) == newpic(ii-1,jj)) ||  (newpic(ii,jj) == newpic(ii,jj+1)) ||  (newpic(ii,jj) == newpic(ii,jj-1)) ||  (newpic(ii,jj) == newpic(ii+1,jj+1)) ||  (newpic(ii,jj) == newpic(ii-1,jj+1)) ||  (newpic(ii,jj) == newpic(ii+1,jj-1)) ||  (newpic(ii,jj) == newpic(ii-1,jj-1)))
                newpic(ii,jj) = 0;
            end
        end
    end
    
    plot(xpic,ypic,'*')

end

numofcells = length(find(newpic>0));