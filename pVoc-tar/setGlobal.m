function  oldVal = setGlobal( var, newVal )

%   var is the name of a variable among the Primary GLOBALs ( an ascii-string ).
%   newVal is the new value 
%   oldVal is the current value
%
%       22.11.04, pm-n.

globals;


if  nargin == 0

 disp( ' Modifiable global parameters:' );
 disp( '  samplingFreq' );
 disp( '  windowSize' );
 disp( '  NSoverNW' );
 disp( '  overlay' );
 disp( '  windowtype' );
 disp( '  maxPeaks' );
 disp( '  epsPeaks' );
 disp( '  soundBufferSize' );

return;
end;

if  strcmp( var, 'samplingFreq' )

     oldVal = FS;

     if nargin == 2
       FS = newVal;
     end;

elseif strcmp( var, 'windowSize' )

     oldVal = TW;

     if nargin == 2
       TW = newVal;
     end;

elseif  strcmp( var, 'NSoverNW' )

     oldVal = NSoverNW;
setGlobal.m
     if nargin == 2
       NSoverNW = newVal;
     end;

elseif  strcmp( var, 'overlay' )

     oldVal = S_OV;

     if nargin == 2
       S_OV = newVal;
     end;

elseif  strcmp( var, 'windowType' )

     oldVal = WINDOW_TYPE;

     if nargin == 2
       WINDOW_TYPE = newVal;
     end;

elseif  strcmp( var, 'maxPeaks' )

     oldVal = MAX_PEAK;

     if nargin == 2
       MAX_PEAK = newVal;
     end;

elseif  strcmp( var, 'epsPeaks' )

     oldVal = EPS_PEAK;

     if nargin == 2
       EPS_PEAK = newVal;
     end;

elseif  strcmp( var, 'soundBufferSize' )

     oldVal = IN_SOUND_BUFFER_SIZE;

     if nargin == 2
       IN_BUFFER_SOUND = newVal;
     end;

else
  

     error( 'Unknown variable' );

end;

if nargin == 2
  calcGlobals;
end;



