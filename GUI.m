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

% Last Modified by GUIDE v2.5 17-Oct-2017 17:31:08

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
% disp("user" + userdataset);
% disp("group" + groupdataset);

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
% disp(FileName);
% disp(FilePath);
% disp("user" + userdataset);
% disp("group" + groupdataset);


% --- Executes on button press in BestNN.
function BestNN_Callback(hObject, eventdata, handles)
% hObject    handle to BestNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global userdataset;
global groupdataset;
global FileName;
global FilePath;
Main(userdataset,groupdataset,FileName,FilePath);
close;

% --- Executes on button press in runNN1.
function runNN1_Callback(hObject, eventdata, handles)
% hObject    handle to runNN1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
