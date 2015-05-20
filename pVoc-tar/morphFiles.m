function  morphFiles( inFile1, inFile2, outFile, sep )

%  inFile1 is morphed into inFile2 over a gap of sep sec.
%
%     22.11.04, pm-n.


globals;

openInSound( 1, inFile1 );
openInSound( 2, inFile2 );

N1 = IN_SOUNDS( 1 ).size;
N2 = IN_SOUNDS( 2 ).size;

nfr = floor( ( N1 + N2 + sep*FS - NW - 1 )/S_HOP + 1 );

% nFrameL is last complete frame before gap.
% nFrameU is first complete frame after gap.

nFrameL = floor( ( N1 - NW + 1 )/S_HOP );
nFrameU = ceil( ( N1 + sep*FS - 1 )/S_HOP + 1 );

out_sound = zeros( N1 + N2 + sep*FS, 1 );

burstLL = getMonoBurst( 1, (nFrameL-2)*S_HOP+1 );
burstL  = getMonoBurst( 1, (nFrameL-1)*S_HOP+1 );
frameLL = burst_2_frame( burstLL );
frameL  = burst_2_frame( burstL, frameLL );

burstU  = getMonoBurst( 2, (nFrameU-1)*S_HOP+1 - (N1+sep*FS) +1 );
burstU.first = (nFrameU-1)*S_HOP+1;
burstUU = getMonoBurst( 2, nFrameU*S_HOP+1 - (N1+sep*FS) +1 );
burstUU.first = nFrameU*S_HOP+1;
frameU  = burst_2_frame( burstU );
frameUU = burst_2_frame( burstUU, frameU );
frameU.freq = frameUU.freq;

for f = 1 : nFrameL
  inBurst = getMonoBurst( 1, (f-1)*S_HOP+1 );
  out_sound( inBurst.first : inBurst.first+NW-1 ) = ...
    out_sound( inBurst.first : inBurst.first+NW-1 ) + inBurst.buffer .* BURST_WINDOW;
end;

prevOutFrame = frameL;
for f = nFrameL+1 : nFrameU
  frameG = morphSpec( frameL, frameU, (f-1)*S_HOP );
  [ outBurst, outFrameRev ] = frame_2_burst( frameG, 2, prevOutFrame );
  out_sound( (f-1)*S_HOP+1 : (f-1)*S_HOP+NW ) = ...
    out_sound( (f-1)*S_HOP+1 : (f-1)*S_HOP+NW ) + outBurst.buffer .* BURST_WINDOW;
  prevOutFrame = outFrameRev;
end;

prevInFrame = frameU;
for f = nFrameU+1 : nfr
  inBurst = getMonoBurst( 2, (f-1)*S_HOP+1 - (N1+sep*FS) +1 );
  inBurst.first = (f-1)*S_HOP+1;
  inFrame = burst_2_frame( inBurst, prevInFrame );
  [ outBurst, outFrameRev ] = frame_2_burst( inFrame, 1, prevOutFrame );
  out_sound( (f-1)*S_HOP+1 : (f-1)*S_HOP+NW ) = ...
    out_sound( (f-1)*S_HOP+1 : (f-1)*S_HOP+NW ) + outBurst.buffer .* BURST_WINDOW;
  prevInFrame = inFrame;
  prevOutFrame = outFrameRev;

end;

outSound( out_sound, outFile );

 
