function varargout = tuner(varargin)
  % TUNER MATLAB code for tuner.fig
  %      TUNER, by itself, creates a new TUNER or raises the existing
  %      singleton*.
  %
  %      H = TUNER returns the handle to a new TUNER or the handle to
  %      the existing singleton*.
  %
  %      TUNER('CALLBACK',hObject,eventData,handles,...) calls the local
  %      function named CALLBACK in TUNER.M with the given input arguments.
  %
  %      TUNER('Property','Value',...) creates a new TUNER or raises the
  %      existing singleton*.  Starting from the left, property value pairs are
  %      applied to the GUI before tuner_OpeningFcn gets called.  An
  %      unrecognized property name or invalid value makes property application
  %      stop.  All inputs are passed to tuner_OpeningFcn via varargin.
  %
  %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
  %      instance to run (singleton)".
  %
  % See also: GUIDE, GUIDATA, GUIHANDLES

  % Edit the above text to modify the response to help tuner

  % Last Modified by GUIDE v2.5 09-Jun-2015 23:56:15

  % Begin initialization code - DO NOT EDIT
  gui_Singleton = 1;
  gui_State = struct('gui_Name',       mfilename, ...
                     'gui_Singleton',  gui_Singleton, ...
                     'gui_OpeningFcn', @tuner_OpeningFcn, ...
                     'gui_OutputFcn',  @tuner_OutputFcn, ...
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

end

% --- Executes just before tuner is made visible.
function tuner_OpeningFcn(hObject, eventdata, handles, varargin)
  % This function has no output args, see OutputFcn.
  % hObject    handle to figure
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)
  % varargin   command line arguments to tuner (see VARARGIN)

  % Choose default command line output for tuner
  handles.output = hObject;

  % Update handles structure
  guidata(hObject, handles);

  % UIWAIT makes tuner wait for user response (see UIRESUME)
  %uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = tuner_OutputFcn(hObject, eventdata, handles) 
  % varargout  cell array for returning output args (see VARARGOUT);
  % hObject    handle to figure
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)

  % Get default command line output from handles structure
  %varargout{1} = handles.output;
end



function sr = sampleRate(h)

   %do this if a user selected a radio button
   switch get(get(h.uibuttongroup_sr,'SelectedObject'),'Tag')
      case 'rb_sr_8000',  sr = 8000;
      case 'rb_sr_11025',  sr = 11025;
      case 'rb_sr_22050',  sr = 22050;
      case 'rb_sr_44100',  sr = 44100;
  end

end


% --- Executes on selection change in popupmenu_seconds.
function popupmenu_seconds_Callback(hObject, eventdata, handles)
  % hObject    handle to popupmenu_seconds (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)

  % Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_seconds contents as cell array
  %        contents{get(hObject,'Value')} returns selected item from popupmenu_seconds
end
% --- Executes during object creation, after setting all properties.
function popupmenu_seconds_CreateFcn(hObject, eventdata, handles)
  % hObject    handle to popupmenu_seconds (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    empty - handles not created until after all CreateFcns called

  % Hint: popupmenu controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
  end
end


% --- Executes on button press in pushbutton_rec.
function pushbutton_rec_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  % Record your voice for x seconds.
  

  L =  str2double(get(handles.edit_length,'String'));
  FS = sampleRate(handles);
  nBits = 16;
  recObj = audiorecorder(FS,nBits,1);
  disp('Start speaking.')
  recordblocking(recObj, L);
  disp('End of Recording.');

  % Store data in double-precision array.
  handles.recordData = getaudiodata(recObj);
  % Save the change you made to the structure
  guidata(hObject,handles)

  axes(handles.axes_time);
  % Plot the waveform.
  plot(handles.recordData);
  xlabel('Tiempo');
  ylabel('Amplitud(t)');

end

% --- Executes on button press in pushbutton_play.
function pushbutton_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  % Play back the recording.
  FS = sampleRate(handles);
  nBits = 16;
  sound(handles.recordData,FS,nBits);
  
end

function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double

end

% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in pushbutton_synth.
function pushbutton_synth_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_synth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


  fs = sampleRate(handles);
  nBits = 16;
  x = handles.recordData;
  
  
  N = length(x);

  % Calculate spectrum
  X = abs(fft(x)); %/N;
  maxX = max(X)
  % Prepare frequency axis
  freqs = (-N/2:N/2-1).*(fs/N);
  
   

  synth_abs_y = zeros(N,1);
  [ pks,idx]=findpeaks(X,'SortStr','descend','NPeaks',1);
  synth_abs_y(idx) = pks;

  %synth = real(ifft(synth_abs_y));
  %synth = real(ifft(y2));
    
  axes(handles.axes_freq);
  hold on;
  
  
  fundamental = 440;
  %rango de semitonos
  st = -36:36;
  freq_tonos = fundamental* 2.^(st/12);
  stem(freq_tonos, ones(length(st))*maxX);  
  disp(max(X));
  % Plot the waveform.
  plot(freqs,fftshift(X));
  xlabel('Frecuencia [Hz]');
  ylabel('Amplitud(X)');


  %axes(handles.axes_notes);


  grid;
  hold off;

  % Plot the waveform.
  %plot(log2(freqs),fftshift(X));
  %xlabel('Frecuencia [Hz]');
  %ylabel('Amplitud(X)');  
  
  
end
