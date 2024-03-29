function [out1,out2,out3] = ginput(arg1)
%GINPUT Graphical input from mouse.
%   [X,Y] = GINPUT(N) gets N points from the current axes and returns
%   the X- and Y-coordinates in length N vectors X and Y.  The cursor
%   can be positioned using a mouse.  Data points are entered by pressing
%   a mouse button or any key on the keyboard except carriage return,
%   which terminates the input before N points are entered.
%
%   [X,Y] = GINPUT gathers an unlimited number of points until the
%   return key is pressed.
%
%   [X,Y,BUTTON] = GINPUT(N) returns a third result, BUTTON, that
%   contains a vector of integers specifying which mouse button was
%   used (1,2,3 from left) or ASCII numbers if a key on the keyboard
%   was used.
%
%   Examples:
%       [x,y] = ginput;
%
%       [x,y] = ginput(5);
%
%       [x, y, button] = ginput(1);
%
%   See also GTEXT, WAITFORBUTTONPRESS.

%   Copyright 1984-2013 The MathWorks, Inc.

out1 = []; out2 = []; out3 = []; y = [];

if ~matlab.ui.internal.isFigureShowEnabled
    error(message('MATLAB:hg:NoDisplayNoFigureSupport', 'ginput'))
end
    
    fig = gcf;
    figure(gcf);
    
    if nargin == 0
        how_many = -1;
        b = [];
    else
        how_many = arg1;
        b = [];
        if  ischar(how_many) ...
                || size(how_many,1) ~= 1 || size(how_many,2) ~= 1 ...
                || ~(fix(how_many) == how_many) ...
                || how_many < 0
            error(message('MATLAB:ginput:NeedPositiveInt'))
        end
        if how_many == 0
            % If input argument is equal to zero points,
            % give a warning and return empty for the outputs.
            
            warning (message('MATLAB:ginput:InputArgumentZero'));
        end
    end
    
    % Setup the figure to disable interactive modes and activate pointers. 
    initialState = setupFcn(fig);
    set (gcf, 'WindowButtonMotionFcn', @mouseMove_new);
    
    % onCleanup object to restore everything to original state in event of
    % completion, closing of figure errors or ctrl+c. 
    c = onCleanup(@() restoreFcn(initialState));
       
    
    % We need to pump the event queue on unix
    % before calling WAITFORBUTTONPRESS
    drawnow
    char = 0;
    
    while how_many ~= 0
        % Use no-side effect WAITFORBUTTONPRESS
        waserr = 0;
        try
            keydown = wfbp;
        catch %#ok<CTCH>
            waserr = 1;
        end
        if(waserr == 1)
            if(ishghandle(fig))
                cleanup(c);
                error(message('MATLAB:ginput:Interrupted'));
            else
                cleanup(c);
                error(message('MATLAB:ginput:FigureDeletionPause'));
            end
        end
        % g467403 - ginput failed to discern clicks/keypresses on the figure it was
        % registered to operate on and any other open figures whose handle
        % visibility were set to off
        figchildren = allchild(0);
        if ~isempty(figchildren)
            ptr_fig = figchildren(1);
        else
            error(message('MATLAB:ginput:FigureUnavailable'));
        end
        %         old code -> ptr_fig = get(0,'CurrentFigure'); Fails when the
        %         clicked figure has handlevisibility set to callback
        if(ptr_fig == fig)
            if keydown
                char = get(fig, 'CurrentCharacter');
                button = abs(get(fig, 'CurrentCharacter'));
            else
                button = get(fig, 'SelectionType');
                if strcmp(button,'open')
                    button = 1;
                elseif strcmp(button,'normal')
                    button = 1;
                elseif strcmp(button,'extend')
                    button = 2;
                elseif strcmp(button,'alt')
                    button = 3;
                else
                    error(message('MATLAB:ginput:InvalidSelection'))
                end
            end
            axes_handle = gca;
            drawnow;
            pt = get(axes_handle, 'CurrentPoint');
            
            how_many = how_many - 1;
            
            if(char == 13) % & how_many ~= 0)
                % if the return key was pressed, char will == 13,
                % and that's our signal to break out of here whether
                % or not we have collected all the requested data
                % points.
                % If this was an early breakout, don't include
                % the <Return> key info in the return arrays.
                % We will no longer count it if it's the last input.
                break;
            end
            
            out1 = [out1;pt(1,1)]; %#ok<AGROW>
            y = [y;pt(1,2)]; %#ok<AGROW>
            b = [b;button]; %#ok<AGROW>
            imsizex = get(gca,'XLim');
            imsizey = get(gca,'YLim');
            oneim = imsizex(2)-imsizex(1);
            if size(y) == 1
                hold on
                plot(out1, y, '*b');
                if out1 > (oneim-20)/2
                    plot(out1 - oneim/2-10, y, '*b');
                else
                    plot(out1 + oneim/2+10, y, '*b');
                end
            else
                plot(out1(end), y(end), '*b');
                plot(out1, y, 'b');
                if out1 > (oneim-20)/2
                    plot(out1(end) - oneim/2-10, y(end), '*b');
                    plot(out1 - oneim/2-10, y, 'b');
                else
                    plot(out1(end) + oneim/2+10, y(end), '*b');
                    plot(out1 + oneim/2+10, y, 'b');
                end
            end
        end
    end
    
    % Cleanup and Restore 
    cleanup(c);
    
    if nargout > 1
        out2 = y;
        if nargout > 2
            out3 = b;
        end
    else
        out1 = [out1 y];
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function key = wfbp
%WFBP   Replacement for WAITFORBUTTONPRESS that has no side effects.

fig = gcf;
current_char = []; %#ok<NASGU>

% Now wait for that buttonpress, and check for error conditions
waserr = 0;
try
    h=findall(fig,'Type','uimenu','Accelerator','C');   % Disabling ^C for edit menu so the only ^C is for
    set(h,'Accelerator','');                            % interrupting the function.
    keydown = waitforbuttonpress;
    current_char = double(get(fig,'CurrentCharacter')); % Capturing the character.
    if~isempty(current_char) && (keydown == 1)          % If the character was generated by the
        if(current_char == 3)                           % current keypress AND is ^C, set 'waserr'to 1
            waserr = 1;                                 % so that it errors out.
        end
    end
    
    set(h,'Accelerator','C');                           % Set back the accelerator for edit menu.
catch %#ok<CTCH>
    waserr = 1;
end
drawnow;
if(waserr == 1)
    set(h,'Accelerator','C');                          % Set back the accelerator if it errored out.
    error(message('MATLAB:ginput:Interrupted'));
end

if nargout>0, key = keydown; end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

function initialState = setupFcn(fig)

% Store Figure Handle. 
initialState.figureHandle = fig; 

% Suspend figure functions
initialState.uisuspendState = uisuspend(fig);

% Disable Plottools Buttons
initialState.toolbar = findobj(allchild(fig),'flat','Type','uitoolbar');
if ~isempty(initialState.toolbar)
    initialState.ptButtons = [uigettool(initialState.toolbar,'Plottools.PlottoolsOff'), ...
        uigettool(initialState.toolbar,'Plottools.PlottoolsOn')];
    initialState.ptState = get (initialState.ptButtons,'Enable');
    set (initialState.ptButtons,'Enable','off');
end

%Setup empty pointer
cdata = NaN(16,16);
hotspot = [8,8];
set(gcf,'Pointer','custom','PointerShapeCData',cdata,'PointerShapeHotSpot',hotspot)

% Create annotations to simulate fullcrosshair pointer.
initialState.CrossHair = createCrossHair(fig);

% Adding this to enable automatic updating of currentpoint on the figure 
% This function is also used to update the display of the fullcrosshair
% pointer annotations and make them track the currentpoint.
set(fig,'WindowButtonMotionFcn',@(o,e) ginputWindowButtonMotion(o,e, initialState.CrossHair));

% Get the initial Figure Units
initialState.fig_units = get(fig,'Units');
end

function restoreFcn(initialState)
if ishghandle(initialState.figureHandle)
    delete(initialState.CrossHair);
    
    % Figure Units
    set(initialState.figureHandle,'Units',initialState.fig_units);
    set(initialState.figureHandle,'WindowButtonMotionFcn','');
    
    % Plottools Icons
    if ~isempty(initialState.toolbar) && ~isempty(initialState.ptButtons)
        set (initialState.ptButtons(1),'Enable',initialState.ptState{1});
        set (initialState.ptButtons(2),'Enable',initialState.ptState{2});
    end
    
    % UISUSPEND
    uirestore(initialState.uisuspendState);    
end
end


function ginputWindowButtonMotion(fig, e, crossHair)
% Manages the simulated display of the full cross hair pointer
updateCrossHair(fig, crossHair);

fig.Pointer = 'custom';
% If we are over a uicontainer then show crosshair. The annotation only draw at the figure level.
if ~isempty(ancestor(e.HitObject, {'uipanel', 'uibuttongroup', 'uicontainer', 'uitabgroup'}, 'toplevel'))
    fig.Pointer = 'crosshair';
end

drawnow update;
end

function updateCrossHair(fig, crossHair)
% update cross hair for figure.
cp = hgconvertunits(fig, [fig.CurrentPoint 0 0], fig.Units, 'normalized', fig);
gap = getGap(fig);

set(crossHair, 'Visible', 'on');
set(crossHair(1), 'X', [0 cp(1)-gap(1)], 'Y', [cp(2) cp(2)]);
set(crossHair(2), 'X', [cp(1)+gap(1) 1], 'Y', [cp(2) cp(2)]);
set(crossHair(3), 'X', [cp(1) cp(1)],  'Y', [0 cp(2)-gap(2)]);
set(crossHair(4), 'X', [cp(1) cp(1)],  'Y', [cp(2)+gap(2) 1]);
end

function crossHair = createCrossHair(fig)
% Create annotations to simulate fullcrosshair pointer.
gap = getGap(fig);
crossHair(1) = annotation(fig, 'line', [0 .5-gap(1)], [.5 .5]); % horizontal left
crossHair(2) = annotation(fig, 'line', [.5+gap(1) 1], [.5 .5]); % horizontal right
crossHair(3) = annotation(fig, 'line', [.5 .5], [0 .5-gap(2)]); % vertical bottom
crossHair(4) = annotation(fig, 'line', [.5 .5], [0.5+gap(2) 1]); % vertical top
set(crossHair, 'LineWidth', 1, 'Visible','off', 'HandleVisibility', 'off', 'HitTest', 'off', 'PickableParts','none');
end

function gap = getGap(obj)
gap = hgconvertunits(ancestor(obj,'figure'), [4 4 0 0], 'pixels', 'normalized', obj);
end

function cleanup(c)
if isvalid(c)
    delete(c);
end
end