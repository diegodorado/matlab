function  calcGlobals

%  Calculate Secondary Globals from the values of
%  the Primary Globals.
%  Note, since some of the SGs are constrained to be integers
%  the values of some PGs may be slightly adjusted.
%
%     22.11.04, pm-n.


globals;


NW = floor( FS*TW + 0.5 );

if NW > IN_SOUND_BUFFER_SIZE
  IN_SOUND_BUFFER_SIZE = NW;
end;

TW = NW/FS;

NS = pow2( ceil( log2( NSoverNW * NW ) ) );

SPECTRUM_SIZE = NS/2 + 1;

WINDOW_OFFSET = floor( (NS-NW)/2 ) + 1;

if  strcmp( WINDOW_TYPE, 'hanning' )
   BURST_WINDOW = hanning( NW );
elseif strcmp( WINDOW_TYPE, 'hanningZ' )
   BURST_WINDOW = 0.5*(1-cos(2*pi*(0:NW-1)'/NW));
elseif strcmp( WINDOW_TYPE, 'hamming' )
   BURST_WINDOW = hamming( NW );
elseif strcmp( WINDOW_TYPE, 'blackman' )
   BURST_WINDOW = blackman( NW );
else
     error( ' Unknown window type ( calcGlobals )' );
end;


S_HOP = floor( NW/S_OV + 0.5 );
S_OV  = NW/S_HOP;


