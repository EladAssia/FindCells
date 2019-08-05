function varargout = FindCellsGUI_new(varargin)
% FINDCELLSGUI_NEW MATLAB code for FindCellsGUI_new.fig
%      FINDCELLSGUI_NEW, by itself, creates a new FINDCELLSGUI_NEW or raises the existing
%      singleton*.
%
%      H = FINDCELLSGUI_NEW returns the handle to a new FINDCELLSGUI_NEW or the handle to
%      the existing singleton*.
%
%      FINDCELLSGUI_NEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINDCELLSGUI_NEW.M with the given input arguments.
%
%      FINDCELLSGUI_NEW('Property','Value',...) creates a new FINDCELLSGUI_NEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FindCellsGUI_new_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FindCellsGUI_new_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FindCellsGUI_new

% Last Modified by GUIDE v2.5 26-Jul-2015 14:38:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FindCellsGUI_new_OpeningFcn, ...
    'gui_OutputFcn',  @FindCellsGUI_new_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FindCellsGUI_new is made visible.
function FindCellsGUI_new_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FindCellsGUI_new (see VARARGIN)

% Choose default command line output for FindCellsGUI_new
handles.output = hObject;
set(handles.OriginalImage,'visible','off')
set(handles.RGB,'visible','off')
set(handles.Filtered,'visible','off')
set(handles.Added,'visible','off')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FindCellsGUI_new wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FindCellsGUI_new_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in image_load.
function image_load_Callback(hObject, eventdata, handles)
% hObject    handle to image_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.ImageName,handles.PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif;*.bmp','All Image Files';});
handles.ImageNamePath = [handles.PathName,handles.ImageName];
linkaxes([handles.OriginalImage, handles.RGB, handles.Added, handles.Filtered], 'xy');
if ishold(handles.RGB)
    hold(handles.RGB);
    hold(handles.Filtered);
    hold(handles.Added);
    hold(handles.OriginalImage);
end
colormap(handles.Filtered, 'gray');
handles.bluereference = false;
[handles] = InitiatingTexts(handles);
handles.Original = imread(handles.ImageNamePath);
imshow(handles.Original, 'Parent', handles.OriginalImage)
imshow(handles.Original,'Parent',handles.Added)

handles.colorchosen = handles.Original(:,:,1);
imshow(handles.colorchosen, 'Parent', handles.RGB);
imshow(ones(size(handles.colorchosen,1),size(handles.colorchosen,2)), 'Parent', handles.Filtered);

reference = questdlg('Do you want a reference from the blue image?', '', 'Yes', 'No', 'No');
if strcmp(reference,'Yes')
    figure;
    imshow(handles.Original(:,:,3));
    questdlg('Please make a line between the part you need and the one you do not need and press enter', '', 'OK', 'OK');
    [x,y] = showginput(100);
    close
    [handles] = MakeCoordinatesCorrection(handles, x, y);
    handles.side = menu('Which side do you wish to leave?','Left','Right','Up', 'Down', 'Circular') + 1;
    [area, handles] = SideChoosen(handles);
    handles.area = area;
    [handles] = LeaveSide(handles);
    handles.Bluebwcolorchosen = handles.bwcolorchosen;
    handles.bluereference = true;
end

figure
if handles.bluereference && strcmp(reference,'Yes')
    imshow(handles.bwcolorchosen);
    hold on
    plot(handles.x, handles.y)
    legend('Blue reference')
    hold(handles.RGB);
    plot(handles.x, handles.y, 'Parent', handles.RGB)
    hold(handles.OriginalImage);
    plot(handles.x, handles.y, 'w', 'Parent', handles.OriginalImage)
else
    imshow(handles.colorchosen);
end
questdlg('Please make a line between the part you need and the one you do not need and press enter', '', 'OK', 'OK');
[x,y] = showginput(100);
close
[handles] = MakeCoordinatesCorrection(handles, x, y);

questdlg('Please choose the side you wish to leave', '', 'OK', 'OK');

guidata(hObject, handles);


% --- Executes on selection change in Side.
function Side_Callback(hObject, eventdata, handles)
% hObject    handle to Side (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.side = get(hObject,'Value');

[area, handles] = SideChoosen(handles);
if ~isempty(handles.x)
    if ~ishold(handles.RGB)
        hold(handles.RGB);
        hold(handles.OriginalImage);
    end
    plot(handles.x, handles.y, 'Parent', handles.RGB)
    plot(handles.x, handles.y, 'w', 'Parent', handles.OriginalImage)
end
if (~handles.bluereference) && (~any(strcmp('area',fieldnames(handles))))
    handles.area = area;
end

[handles] = LeaveSide(handles);
imshow(handles.Conbwcolorchosen, 'Parent', handles.Filtered)
%[handles, newpic] = FilterImage(handles);

guidata(hObject, handles);
questdlg('Please choose the contrast you wish or press "Make Cells"', '', 'OK', 'OK');


% Hints: contents = cellstr(get(hObject,'String')) returns Side contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Side


% --- Executes during object creation, after setting all properties.
function Side_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Side (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Contrast_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Contrast = get(handles.Contrast, 'value');
handles.Conbwcolorchosen = im2bw(handles.bwcolorchosen, Contrast);
imshow(handles.Conbwcolorchosen, 'Parent', handles.Filtered)

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in Make_Cells.
function Make_Cells_Callback(hObject, eventdata, handles)
% hObject    handle to Make_Cells (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.filteredimage = handles.Conbwcolorchosen;

if max(size(handles.Original))/10000 >= 1
    handles.factor = 64;
elseif max(size(handles.Original))/7500 >= 1
    handles.factor = 49;
elseif max(size(handles.Original))/5000 >= 1
    handles.factor = 36;
elseif max(size(handles.Original))/2500 >= 1
    handles.factor = 25;
elseif max(size(handles.Original))/1000 >= 1
    handles.factor = 16;
else
    handles.factor = 4;
end


[handles] = RemoveSurround(handles);

[handles] = MakeCells(handles);

imshow(handles.filteredimage, 'Parent', handles.Filtered);

if ~ishold(handles.Filtered)
    hold(handles.Filtered);
    hold(handles.Added);
end
if ~ishold(handles.RGB)
    hold(handles.RGB);
    hold(handles.OriginalImage);
end

handles.addedcells = double(handles.filteredimage);
handles.addedcells(find(handles.addedcells>0)) = 250;

guidata(hObject, handles);
questdlg('The filtering is done. Press count to count the cells or change the color/side of you choice. You may also add or remove cells', '', 'OK', 'OK');


% --- Executes on button press in cursor.
function cursor_Callback(hObject, eventdata, handles)
% hObject    handle to cursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[x, y] = waitForMousePress;



% --- Executes during object creation, after setting all properties.
function OriginalImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OriginalImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate OriginalImage


% --- Executes during object deletion, before destroying properties.
function OriginalImage_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to OriginalImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function OriginalImage_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to OriginalImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in CountCells.
function CountCells_Callback(hObject, eventdata, handles)

imshow(handles.addedcells,'Parent',handles.Added)

count = ceil(length(find(handles.addedcells))/handles.factor);
[posy, posx] = find(handles.addedcells);


handles.redcells = count;
handles.redcellspos = [posx, posy];
[handles] = rearrangePosition(handles);
handles.cellx = handles.redcellspos(1:handles.factor:end,2);
handles.celly = handles.redcellspos(1:handles.factor:end,1);
handles.redfinal = handles.addedcells;
set(handles.RedCells, 'String', ['Red Cells: ', num2str(count)])

[handles] = CircleCells(handles, 'Yes', '0');
guidata(hObject, handles);

% hObject    handle to CountCells (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function Grid_Callback(hObject, eventdata, handles)
% hObject    handle to Grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes on slider movement.
function SD_Callback(hObject, eventdata, handles)
% hObject    handle to SD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes on button press in Heat_Map.
function Heat_Map_Callback(hObject, eventdata, handles)
% hObject    handle to Heat_Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles] = myHeatmap(handles);
delete(handles.Filtered.Children);
handles.Filtered.CLimMode = 'auto';
handles.newHeatMap = imresize(handles.heatMap, (size(handles.Original,1)/size(handles.heatMap,1) + size(handles.Original,2)/size(handles.heatMap,2))/2);
imagesc(handles.newHeatMap, 'Parent', handles.Filtered);
colormap(handles.Filtered, 'jet');
axes(handles.Filtered);
colorbar;

guidata(hObject, handles);


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2



function pixels_Callback(hObject, eventdata, handles) % Pixels
% hObject    handle to pixels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pixels as text
%        str2double(get(hObject,'String')) returns contents of pixels as a double


% --- Executes during object creation, after setting all properties.
function pixels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pixels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in size.
function size_Callback(hObject, eventdata, handles) %size
% hObject    handle to size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns size contents as cell array
%        contents{get(hObject,'Value')} returns selected item from size
proportion = (str2double(get(handles.real_length, 'string'))/str2double(get(handles.pixels, 'string')))^2*handles.area;

if get(handles.size, 'value') == 2
    metre = 'cm';
elseif get(handles.size, 'value') == 3
    metre = 'mm';
elseif get(handles.size, 'value') == 4
    metre = 'um';
elseif get(handles.size, 'value') == 5
    metre = 'nm';
end

if any(strcmp('redcells',fieldnames(handles)))
    handles.redCellsDensity = handles.redcells/proportion;
    set(handles.RedDensity, 'String', ['Red Cells Density: ', num2str(handles.redCellsDensity), ' cells per square ', metre])
end

if any(strcmp('greencells',fieldnames(handles)))
    handles.greenCellsDensity = handles.greencells/proportion;
    set(handles.GreenDensity, 'String', ['Green Cells Density: ', num2str(handles.greenCellsDensity), ' cells per square ', metre])
end

if any(strcmp('bluecells',fieldnames(handles)))
    handles.blueCellsDensity = handles.bluecells/proportion;
    set(handles.BlueDensity, 'String', ['Blue Cells Density: ', num2str(handles.blueCellsDensity), ' cells per square ', metre])
end


guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function real_length_Callback(hObject, eventdata, handles) % Real length
% hObject    handle to real_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of real_length as text
%        str2double(get(hObject,'String')) returns contents of real_length as a double


% --- Executes during object creation, after setting all properties.
function real_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to real_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Convert.
function Convert_Callback(hObject, eventdata, handles)
% hObject    handle to Convert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Convert contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Convert
size = get(handles.size, 'value');
convert = get(handles.Convert, 'value');
diff = convert - size;

if get(handles.Convert, 'value') == 2
    metre = 'cm';
elseif get(handles.Convert, 'value') == 3
    metre = 'mm';
elseif get(handles.Convert, 'value') == 4
    metre = 'um';
elseif get(handles.Convert, 'value') == 5
    metre = 'nm';
end

if diff == 0
    changeProportion = 1;
elseif diff == 1
    changeProportion = 1/1000^2;
elseif diff == 2
    changeProportion = 1/1000000^2;
elseif diff == 3
    changeProportion = 1/1000000000^2;
elseif diff == -1
    changeProportion = 1*1000^2;
elseif diff == -2
    changeProportion = 1*1000000^2;
elseif diff == -3
    changeProportion = 1*1000000000^2;
end


if any(strcmp('redCellsDensity',fieldnames(handles)))
    set(handles.RedDensityCon, 'String', ['Red Cells Density: ', num2str(handles.redCellsDensity*changeProportion), ' cells per square ', metre])
end

if any(strcmp('greenCellsDensity',fieldnames(handles)))
    set(handles.GreenDensityCon, 'String', ['Green Cells Density: ', num2str(handles.greenCellsDensity*changeProportion), ' cells per square ', metre])
end

if any(strcmp('blueCellsDensity',fieldnames(handles)))
    set(handles.BlueDensityCon, 'String', ['Blue Cells Density: ', num2str(handles.blueCellsDensity*changeProportion), ' cells per square ', metre])
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Convert_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Convert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddCell.
function AddCell_Callback(hObject, eventdata, handles)
% hObject    handle to AddCell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles] = AddCells(handles);
imshow(handles.addedcells,'Parent',handles.Added)
delete(handles.Added.Children(end));

guidata(hObject, handles);

% --- Executes on button press in RemoveCell.
function RemoveCell_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveCell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles] = SubCells(handles);
imshow(handles.addedcells,'Parent',handles.Added)
delete(handles.Added.Children(end));

guidata(hObject, handles);


% --- Executes on button press in Overlap.
function Overlap_Callback(hObject, eventdata, handles)
% hObject    handle to Overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles] = findTheOverlappingCells(handles);


guidata(hObject, handles);

% --- Executes on button press in save_images.
function save_images_Callback(hObject, eventdata, handles)
% hObject    handle to save_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

savefilename = [handles.ImageName(1:end-4), '_filtered.tif'];
imwrite(handles.addedcells, savefilename);
savefilename = [handles.ImageName(1:end-4), '_Red_filter.tif'];
imwrite(handles.colorchosen, savefilename);
if any(strcmp('newHeatMap',fieldnames(handles)))
    figure;
    imagesc(handles.newHeatMap);
    colormap('jet');
    tmp2=getframe;
    image(tmp2.cdata);
    savefilename = [handles.ImageName(1:end-4), '_Heat_Map.tif'];
    imwrite(tmp2.cdata, savefilename);
    close
end


% --- Executes on button press in Save_Date.
function Save_Date_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
savefilename = [handles.ImageName(1:end-3), 'mat'];
save(savefilename, 'handles');




% --- Executes on button press in Load_Data.
function Load_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Load_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loadfilename = uigetfile({'*.mat';});
load(loadfilename);


% --- Executes during object deletion, before destroying properties.
function uitoggletool8_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to uitoggletool8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in remove_area.
function remove_area_Callback(hObject, eventdata, handles)
% hObject    handle to remove_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[handles] = RemoveArea(handles);
imshow(handles.addedcells,'Parent',handles.Added)
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function Grid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function SD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
