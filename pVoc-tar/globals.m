
% GLOBALs for 'pVoc, 11.3.03, pm-n'.
%
%     22.11.04, pm-n.
%
%  The GLOBALs are divided into two categories: Primary GLOBALs ( PG )
%  and Secondary GLOBALs ( SG ).The PGs are set to default values in
%  "initGlobals" and they should be modified only by means of the
%  operation "setGlobal( var, val )" The SGs are calculated from
%  the PGs by calling the function "calcGlobals".
%
%
%  Primary GLOBALs:
% ==================

global  FS              % The sampling frequency ( in Hz ).

global  TW              % Window size ( in Sec. )
global  NSoverNW        % The min. value of NS/NW
global  S_OV            % Overlay during synthesis.
global  WINDOW_TYPE     % Window type.

global  MAX_PEAK        % Max. no. of partitions/peaks in synthesis.
global  EPS_PEAK        % Limit of significance.

global  IN_SOUND_BUFFER_SIZE  % the max. size of the buffer for InSound

global  IN_SOUNDS        % A vector of 'Sounds'.

%  Secondary GLOBALs:
% ====================

global  NW              % Window size ( in samples ).
global  NS              % Size of padded window ( in samples ).
                        % The smallest power of two larger or equal to NW.
global  SPECTRUM_SIZE   % The size of the spectra in a Frame.
global  WINDOW_OFFSET   % Index of first of burst in the padded burst.
global  BURST_WINDOW    % The window, a vector of size NW.

global  S_HOP           % Hop during synthesis ( in samples ).



   
% ========================================================================

%   Structures:
%   ===========
%
%   Sound:  
%      .file : a string, the name of the wav-file.
%      .size : the total no. of samples in the sound ( i.e. the wav-file ).
%              = 0 means undefined.
%      .channels : the no. of channels.
%      .buffer : [1:<buffer size>] contains a sequence of samples.
%      .first  : sample-no. of buffer(1).
%
%       IN_SOUNDS is a vector of Sounds that cab be opened for input.
%
%   Burst:
%      .first : sample-no of buffer(1).
%      .buffer : [1:<burst size>] contains the samples of the burst.
%                Normally <burst size> is NW. A smaller number signals
%                end of sound.
%
%   Frame:
%      .first : sample-no of the first sample of the burst associated
%               with the frame.
%      .amp : [1:<spec size>] contains the amplitude spectrum
%      .phase :  -,,-         contains the phase spectrum
%      .freq :   -,,-         contains the freq spectrum ( if any ).


% ========================================================================

%    Conventions:
%    ============
%
%  All vectors are columns.

