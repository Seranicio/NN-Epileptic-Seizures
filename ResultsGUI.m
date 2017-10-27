function varargout = ResultsGUI(varargin)
% RESULTSGUI MATLAB code for ResultsGUI.fig
%      RESULTSGUI, by itself, creates a new RESULTSGUI or raises the existing
%      singleton*.
%
%      H = RESULTSGUI returns the handle to a new RESULTSGUI or the handle to
%      the existing singleton*.
%
%      RESULTSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTSGUI.M with the given input arguments.
%
%      RESULTSGUI('Property','Value',...) creates a new RESULTSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ResultsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ResultsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ResultsGUI

% Last Modified by GUIDE v2.5 26-Oct-2017 18:20:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ResultsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ResultsGUI_OutputFcn, ...
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


% --- Executes just before ResultsGUI is made visible.
function ResultsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ResultsGUI (see VARARGIN)

% Choose default command line output for ResultsGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ResultsGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global sens;
global spec;
global Preictal;
global Ictal;
global Acc;
set(handles.sens,'String',sens + "%");
set(handles.spec,'String',spec + "%");
set(handles.preictalacc,'String',Preictal + "%");
set(handles.ictalacc,'String',Ictal + "%");
set(handles.acc,'String',Acc + "%");

% --- Outputs from this function are returned to the command line.
function varargout = ResultsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
