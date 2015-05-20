function  openInSound( track_no, filename )

%   Associate IN_SOUND( track_no ) with the sound in <filename>.wav
%
%      9.5.03, pm-n.

globals;

IN_SOUNDS( track_no ).size = 0;    %  clear the track.

res = wavread( filename, 'size' );
IN_SOUNDS( track_no ).size = res(1);
IN_SOUNDS( track_no ).channels = res(2);

first = 1;
if IN_SOUNDS( track_no ).size > IN_SOUND_BUFFER_SIZE
   last = IN_SOUND_BUFFER_SIZE;
else
   last = IN_SOUNDS( track_no ).size;
end;

[ IN_SOUNDS( track_no ).buffer, fs, bits ] = wavread( filename, [first  last] );

IN_SOUNDS( track_no ).file = filename;
IN_SOUNDS( track_no ).first = 1;

if FS ~= fs
  FS = fs;
  calcGlobals;
end;

