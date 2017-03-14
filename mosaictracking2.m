function varargout = mosaictracking2(varargin)
% MOSAICTRACKING2 MATLAB code for mosaictracking2.fig
%      MOSAICTRACKING2, by itself, creates a new MOSAICTRACKING2 or raises the existing
%      singleton*.
%
%      H = MOSAICTRACKING2 returns the handle to a new MOSAICTRACKING2 or the handle to
%      the existing singleton*.
%
%      MOSAICTRACKING2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOSAICTRACKING2.M with the given input arguments.
%
%      MOSAICTRACKING2('Property','Value',...) creates a new MOSAICTRACKING2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mosaictracking2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mosaictracking2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mosaictracking2

% Last Modified by GUIDE v2.5 12-Jul-2016 15:47:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mosaictracking2_OpeningFcn, ...
                   'gui_OutputFcn',  @mosaictracking2_OutputFcn, ...
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


% --- Executes just before mosaictracking2 is made visible.
function mosaictracking2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mosaictracking2 (see VARARGIN)

% Choose default command line output for mosaictracking2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mosaictracking2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
setappdata(0,'hMain',gcf);

% --- Outputs from this function are returned to the command line.
function varargout = mosaictracking2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in choosemat.
function choosemat_Callback(hObject, eventdata, handles)
% hObject    handle to choosemat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[matfile,pathname] = uigetfile('*.mat','Choose Calibration .mat file...');
calibdata = load(fullfile(pathname,matfile));
objmag = calibdata.objmag;
if isfield(calibdata,'d');
    d = calibdata.d;
elseif isfield(calibdata,'dg');
    d = calibdata.dg;
elseif isfield(calibdata','dr');
    d = calibdata.dr;
end
setappdata(handles.choosemat,'pathname',pathname);
setappdata(handles.choosemat,'matfile',matfile);
setappdata(handles.choosemat,'objmag',objmag);
setappdata(handles.choosemat,'d',d);
set(handles.dispmat,'String',fullfile(pathname,matfile));
cd(pathname);
hMain = getappdata(0,'hMain');
setappdata(hMain,'pathmat',pathname);
setappdata(hMain,'matfile',matfile);

% --- Executes on button press in chooseh5.
function chooseh5_Callback(hObject, eventdata, handles)
% hObject    handle to chooseh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filelist,pathname] = uigetfile('*.h5','Choose Data File(s)...','MultiSelect','on');
setappdata(handles.chooseh5,'filelist',filelist);
setappdata(handles.chooseh5,'pathname',pathname);
set(handles.disph5,'String',filelist)
hMain = getappdata(0,'hMain');
setappdata(hMain,'pathdata',pathname);
setappdata(hMain,'filelist',filelist);

% --- Executes on selection change in disph5.
function disph5_Callback(hObject, eventdata, handles)
% hObject    handle to disph5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns disph5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from disph5


% --- Executes during object creation, after setting all properties.
function disph5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disph5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radius_Callback(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius as text
%        str2double(get(hObject,'String')) returns contents of radius as a double


% --- Executes during object creation, after setting all properties.
function radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function score_Callback(hObject, eventdata, handles)
% hObject    handle to score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of score as text
%        str2double(get(hObject,'String')) returns contents of score as a double


% --- Executes during object creation, after setting all properties.
function score_CreateFcn(hObject, eventdata, handles)
% hObject    handle to score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thresh_Callback(hObject, eventdata, handles)
% hObject    handle to thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh as text
%        str2double(get(hObject,'String')) returns contents of thresh as a double


% --- Executes during object creation, after setting all properties.
function thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function link_Callback(hObject, eventdata, handles)
% hObject    handle to link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of link as text
%        str2double(get(hObject,'String')) returns contents of link as a double


% --- Executes during object creation, after setting all properties.
function link_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function displace_Callback(hObject, eventdata, handles)
% hObject    handle to displace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of displace as text
%        str2double(get(hObject,'String')) returns contents of displace as a double


% --- Executes during object creation, after setting all properties.
function displace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to displace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minlength_Callback(hObject, eventdata, handles)
% hObject    handle to minlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minlength as text
%        str2double(get(hObject,'String')) returns contents of minlength as a double


% --- Executes during object creation, after setting all properties.
function minlength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runtracking.
function runtracking_Callback(hObject, eventdata, handles)
% hObject    handle to runtracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
objmag = getappdata(handles.choosemat,'objmag');
xypixel = 16000/objmag*150/200;
d = getappdata(handles.choosemat,'d');
pathname = getappdata(handles.chooseh5,'pathname');
filelist = getappdata(handles.chooseh5,'filelist');
if ~iscell(filelist)
    filelist = {filelist};
end
radius = get(handles.radius,'String');
score = get(handles.score,'String');
thresh = get(handles.thresh,'String');
link = get(handles.link,'String');
displace = num2str(str2double(get(handles.displace,'String'))/xypixel);
minlength = str2double(get(handles.minlength,'String'));
process = get(handles.preprocess,'value');
rollingrad = str2double(get(handles.rollingrad,'String'));
gaussrad = str2double(get(handles.gaussrad,'String'));
mosaicspt(pathname,filelist,radius,score,thresh,link,displace,minlength,objmag,d,process,rollingrad,gaussrad);


% --- Executes on button press in runtracksanalyze.
function runtracksanalyze_Callback(hObject, eventdata, handles)
% hObject    handle to runtracksanalyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tracksanalyze;


% --- Executes on button press in preprocess.
function preprocess_Callback(hObject, eventdata, handles)
% hObject    handle to preprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of preprocess



function rollingrad_Callback(hObject, eventdata, handles)
% hObject    handle to rollingrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rollingrad as text
%        str2double(get(hObject,'String')) returns contents of rollingrad as a double


% --- Executes during object creation, after setting all properties.
function rollingrad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rollingrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaussrad_Callback(hObject, eventdata, handles)
% hObject    handle to gaussrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussrad as text
%        str2double(get(hObject,'String')) returns contents of gaussrad as a double


% --- Executes during object creation, after setting all properties.
function gaussrad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
