function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 25-Oct-2017 00:32:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global groupdataset;
groupdataset = 1;
global userdataset;
userdataset = 0;
global FileName;
global FilePath;
FileName = "null";
FilePath = "null";
global trainingf;
trainingf = 1;
global nntype;
nntype = 1;
global hiddenlayer;
hiddenlayer = 10;
disp("This NN Program will use the GPU. Having not suficient memory is possible"); %TODO: divide input.

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in groupdataset.
function groupdataset_Callback(hObject, eventdata, handles)
% hObject    handle to groupdataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of groupdataset
set(handles.browsedataset,'Value',0);
set(handles.groupdataset,'Value',1);
global groupdataset;
groupdataset = 1;
global userdataset;
userdataset = 0;
global FileName;
global FilePath;
FileName = "null";
FilePath = "null";

% --- Executes on button press in browsedataset.
function browsedataset_Callback(hObject, eventdata, handles)
% hObject    handle to browsedataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of browsedataset
set(handles.browsedataset,'Value',1);
set(handles.groupdataset,'Value',0);
global groupdataset;
groupdataset = 0;
global userdataset;
userdataset = 1;
global FileName;
global FilePath;
[FileName,FilePath]= uigetfile();

% --- Executes on button press in BestNN.
function BestNN_Callback(hObject, eventdata, handles)
% hObject    handle to BestNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global userdataset;
global groupdataset;
global FileName;
global FilePath;
global trainingf;
global nntype;
global hiddenlayer;
valRatio = get(handles.Validation,'String');
trainRatio = get(handles.Train,'String');
testRatio = get(handles.Test,'String');
valRatio = "" + valRatio;
trainRatio = "" + trainRatio;
testRatio = "" + testRatio;
close;
Main(FileName,FilePath,double(trainRatio),double(testRatio),double(valRatio),nntype,trainingf,hiddenlayer);


% --- Executes on button press in runNN1.
function runNN1_Callback(hObject, eventdata, handles)
% hObject    handle to runNN1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Train_Callback(hObject, eventdata, handles)
% hObject    handle to Train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Train as text
%        str2double(get(hObject,'String')) returns contents of Train as a double


% --- Executes during object creation, after setting all properties.
function Train_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Test_Callback(hObject, eventdata, handles)
% hObject    handle to Test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Test as text
%        str2double(get(hObject,'String')) returns contents of Test as a double


% --- Executes during object creation, after setting all properties.
function Test_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Validation_Callback(hObject, eventdata, handles)
% hObject    handle to Validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Validation as text
%        str2double(get(hObject,'String')) returns contents of Validation as a double


% --- Executes during object creation, after setting all properties.
function Validation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in normalfeed.
function normalfeed_Callback(hObject, eventdata, handles)
% hObject    handle to normalfeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of normalfeed
global normalfeed;
normalfeed = 1;
set(handles.recurrent,'Value',0);
set(handles.normalfeed,'Value',1);

% --- Executes on button press in recurrent.
function recurrent_Callback(hObject, eventdata, handles)
% hObject    handle to recurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of recurrent
global normalfeed;
normalfeed = 0;
set(handles.recurrent,'Value',1);
set(handles.normalfeed,'Value',0);


% --- Executes on selection change in trainingfunction.
function trainingfunction_Callback(hObject, eventdata, handles)
% hObject    handle to trainingfunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns trainingfunction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from trainingfunction
global trainingf;
trainingf = get(handles.trainingfunction,'Value');

% --- Executes during object creation, after setting all properties.
function trainingfunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trainingfunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in nntype.
function nntype_Callback(hObject, eventdata, handles)
% hObject    handle to nntype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns nntype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from nntype
global nntype;
nntype = get(handles.nntype,'Value');

% --- Executes during object creation, after setting all properties.
function nntype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nntype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in hiddenlayer.
function hiddenlayer_Callback(hObject, eventdata, handles)
% hObject    handle to hiddenlayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hiddenlayer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hiddenlayer
global hiddenlayer;
hiddenlayer = get(handles.hiddenlayer,'Value');
if(hiddenlayer == 1)
    hiddenlayer = 10;
elseif(hiddenlayer == 2)
    hiddenlayer = 20;
elseif(hiddenlayer == 3)
    hiddenlayer = 29;
else
    hiddenlayer = 30;
end

% --- Executes during object creation, after setting all properties.
function hiddenlayer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hiddenlayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
