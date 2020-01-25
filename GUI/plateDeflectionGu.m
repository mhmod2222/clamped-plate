function varargout = plateDeflectionGu(varargin)
% PLATEDEFLECTIONGU MATLAB code for plateDeflectionGu.fig
%      PLATEDEFLECTIONGU, by itself, creates a new PLATEDEFLECTIONGU or raises the existing
%      singleton*.
%
%      H = PLATEDEFLECTIONGU returns the handle to a new PLATEDEFLECTIONGU or the handle to
%      the existing singleton*.
%
%      PLATEDEFLECTIONGU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATEDEFLECTIONGU.M with the given input arguments.
%
%      PLATEDEFLECTIONGU('Property','Value',...) creates a new PLATEDEFLECTIONGU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plateDeflectionGu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plateDeflectionGu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plateDeflectionGu

% Last Modified by GUIDE v2.5 14-Jan-2016 18:39:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plateDeflectionGu_OpeningFcn, ...
                   'gui_OutputFcn',  @plateDeflectionGu_OutputFcn, ...
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


% --- Executes just before plateDeflectionGu is made visible.
function plateDeflectionGu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plateDeflectionGu (see VARARGIN)

% Choose default command line output for plateDeflectionGu
handles.output = hObject;
set(handles.edit1,'String','') %%empty text  box
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plateDeflectionGu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plateDeflectionGu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'value')
    n = get(handles.edit1,'String'); %number of divisions in length
    n = str2num(n);
    l = get(handles.edit2,'String');
    l = str2num(l);
    e = get(handles.edit3,'String');
    e = str2num(e);
    mu = get(handles.edit4,'String');
    mu = str2num(mu); 
    h = get(handles.edit5,'String');
    h = str2num(h);
    p = get(handles.edit6,'String');
    p = str2num(p);
    d = (h^3*e)/12*(1-mu^2);
    lamda = l/n;
    m = sym('m_%d_%d',[n n]);
    fu = ones(n^2,1)*(-lamda^4*p/d); %load vector
    q = zeros(n^2,n^2);
    xx=1;
    for j=1:n
        for i=1:n
                %%%%%%% fixed corner
                %%%%%%% 1
            if (i==1&&j==1)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i,j+1)+m(i+1,j))+2*m(i+1,j+1)+m(i,j+2)+m(i+2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 2
            elseif (i==1&&j==n)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i,j-1))+2*m(i+1,j-1)+m(i,j-2)+m(i+2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 3
            elseif (i==n&&j==1)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i,j+1)+m(i-1,j))+2*m(i-1,j+1)+m(i-2,j)+m(i,j+2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 4
            elseif (i==n&&j==n)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i,j-1))+2*m(i-1,j-1)+m(i,j-2)+m(i-2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%% fixed edge "2nd" or "nth-1" point only
                %%%%%%% 1-A
            elseif (i==1&&j==2)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i+1,j-1)+m(i+1,j+1))+m(i,j+2)+m(i+2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
            elseif (i==1&&j==n-1)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i+1,j-1)+m(i+1,j+1))+m(i,j-2)+m(i+2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 2-A
            elseif (i==n&&j==2)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i,j-1)+m(i,j+1)+m(i-1,j))+2*(m(i-1,j-1)+m(i-1,j+1))+m(i,j+2)+m(i-2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
            elseif (i==n&&j==n-1)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i,j-1)+m(i,j+1)+m(i-1,j))+2*(m(i-1,j-1)+m(i-1,j+1))+m(i-2,j)+m(i,j-2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 3-A
            elseif (j==1&&i==2)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i,j+1)+m(i+1,j))+2*(m(i-1,j+1)+m(i+1,j+1))+m(i,j+2)+m(i+2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
            elseif (j==1&&i==n-1)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1))+m(i,j+2)+m(i-2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 4-A
            elseif (j==n&&i==2)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i-1,j)+m(i,j-1))+2*(m(i+1,j-1)+m(i-1,j-1))+m(i+2,j)+m(i,j-2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
            elseif (j==n&&i==n-1)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i-1,j)+m(i,j-1))+2*(m(i+1,j-1)+m(i-1,j-1))+m(i-2,j)+m(i,j-2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%% fixed edge
                %%%%%%% 1-B
            elseif (i==1&&j>2&&j<n-1)
                [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i,j-1)+m(i,j+1)+m(i+1,j))+2*(m(i+1,j-1)+m(i+1,j+1))+m(i+2,j)+m(i,j+2)+m(i,j-2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 2-B
            elseif (i==n&&j>2&&j<n-1)
                [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i,j-1)+m(i,j+1)+m(i-1,j))+2*(m(i-1,j-1)+m(i-1,j+1))+m(i,j+2)+m(i-2,j)+m(i,j-2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 3-B
            elseif (j==1&&i>2&&i<n-1)
                [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1))+m(i,j+2)+m(i+2,j)+m(i-2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 4-B
            elseif (j==n&&i>2&&i<n-1)
                [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i+1,j)+m(i-1,j)+m(i,j-1))+2*(m(i+1,j-1)+m(i-1,j-1))+m(i+2,j)+m(i,j-2)+m(i-2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%% adjacent to fixed corner
                %%%%%%% 1
            elseif (i==2&&j==2)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j+2)+m(i+2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 2
            elseif (i==2&&j==n-1)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j-2)+m(i+2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 3
            elseif (i==n-1&&j==2)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i-2,j)+m(i,j+2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 4
            elseif (i==n-1&&j==n-1)
                [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i-2,j)+m(i,j-2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%% adjacent to fixed corner "2nd" or "nth-1"
                %%%%%%% 1
            elseif (i==2&&j>2&&j<n-1)
                [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j+2)+m(i+2,j)+m(i,j-2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 2
            elseif (i==n-1&&j>2&&j<n-1)
                [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j+2)+m(i-2,j)+m(i,j-2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 3
            elseif (j==2&&i>2&&i<n-1)
                [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j+2)+m(i-2,j)+m(i+2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%%
                %%%%%%% 4
            elseif (j==n-1&&i>2&&i<n-1)
                [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j-2)+m(i-2,j)+m(i+2,j),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
                %%%%%%% general point
                %%%%%%%
            else
                [Temp1,Temp2]=equationsToMatrix(20*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i-2,j)+m(i,j+2)+m(i+2,j)+m(i,j-2),m);
                q(xx,:) = Temp1(:);
                Temp1=0;
                xx=xx+1;
            end
        end
    end
    q=double(q);
    m = linsolve(q,fu);
    tableData(:,1) = 1:n^2;
    tableData(:,2) = m;
    set(handles.uitable1,'data',tableData);
    m = reshape(m',n,n)';
    m = [zeros(1,n+2);zeros(n,1),m, zeros(n,1);zeros(1,n+2)];
    x = linspace(0,n,n+2);
    x = x';
    y = x;
    axes(handles.axes1),mesh(x,y,m)
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
