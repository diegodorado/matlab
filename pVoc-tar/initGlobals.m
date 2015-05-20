function  initGlobals

% Set default values of Primary GLOBALs and calulate
% Secondary GLOBALs.
%
%   22.11.04, pm-n.

globals;

FS          = 44100;

TW          = 2048/FS;       % = 46 msec. 
NSoverNW    = 2;
S_OV        = 8;
WINDOW_TYPE = 'hanningZ';

MAX_PEAK    = 50;
EPS_PEAK    = 0.005;

IN_SOUND_BUFFER_SIZE  = 2*FS;

IN_SOUNDS = [];

calcGlobals;



