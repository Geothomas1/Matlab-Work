function varargout = guipreprocessing(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name', mfilename, ...
 'gui_Singleton', gui_Singleton, ...
 'gui_OpeningFcn', @guipreprocessing_OpeningFcn, ...
 'gui_OutputFcn', @guipreprocessing_OutputFcn, ...
 'gui_LayoutFcn', [] , ...
 'gui_Callback', []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
 [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
 gui_mainfcn(gui_State, varargin{:});
end
function guipreprocessing_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = guipreprocessing_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
for index=1:10;
 name=sprintf('%d.jpg',index);
 I1{index}=imread(name);
 I=I1{index};
 axes(handles.axes1);
 imshow(I);
 b=rgb2gray(I);
 c=im2double(b);
 J=log(1+c);
 sigma=10;
 M=2*size(J,1)+1;
 N=2*size(J,2)+1;
 [X,Y]=meshgrid(1:N,1:M);
 centerX=ceil(N/2);
 centerY=ceil(M/2);
 gaussianNumerator=(X-centerX).^2+(Y-centerY).^2;
 H=exp(-gaussianNumerator./(2*sigma.^2));
 H=1-H;
  H=fftshift(H)
   If=fft2(J,M,N);
 Iout=real(ifft2(H.*If));
 Iout=Iout(1:size(J,1),1:size(J,2));
 Ihmf=exp(Iout)-1;
 axes(handles.axes2);
 imshowpair(J,Ihmf,'montage');
end;
  
 
