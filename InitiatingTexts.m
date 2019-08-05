function [handles] = InitiatingTexts(handles)

set(handles.RedCells, 'String', ['Red Cells: '])
set(handles.RedDensity, 'String', ['Red Cells Density: '])
set(handles.RedDensityCon, 'String', ['Red Cells Density: '])
set(handles.Side, 'value', 1)
set(handles.pixels, 'String', ['Pixels'])
set(handles.real_length, 'String', ['Real Length'])
set(handles.size, 'value', 1)
set(handles.Convert, 'value', 1)
set(handles.Contrast, 'value', 0.5)

if any(strcmp('area',fieldnames(handles)))
    handles = rmfield(handles, 'area');
end
if any(strcmp('reference',fieldnames(handles)))
    handles = rmfield(handles, 'reference');
end
if any(strcmp('redcells',fieldnames(handles)))
    handles = rmfield(handles, 'redcells');
    handles = rmfield(handles, 'redcellspos');
end
if any(strcmp('Original',fieldnames(handles)))
    handles = rmfield(handles, 'Original');
    handles = rmfield(handles, 'colorchosen');
end
try
    handles = rmfield(handles, 'bwcolorchosen');
catch
end
try
    handles = rmfield(handles, 'filteredimage');
catch
end