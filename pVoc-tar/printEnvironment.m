function  printEnvironment;

%  Print the values of the parameters in the 'environment',
%  i.e. the globals.

%   22.11.04, pm-n.


globals;

fprintf( '\n\n Environment:\n\n' );

fprintf( 'Sampl. freq.:  %d \n', FS );
fprintf( 'Window size:  %f ( sec. )\n', TW );
fprintf( 'SoverB:  %f \n', NSoverNW );
fprintf( 'Synth. overlap:  %f \n', S_OV );
fprintf( 'WindowType:  %s \n', WINDOW_TYPE );
fprintf( 'Max. no. of peaks:  %d \n', MAX_PEAK );
fprintf( 'Min. peak size ( rel. ):  %f \n', EPS_PEAK );
fprintf( 'Buffer size ( InSound ):  %d \n', IN_SOUND_BUFFER_SIZE );


fprintf( '\n Derived values: \n\n' );

fprintf( 'Window size:  %d ( samples )\n', NW );
fprintf( 'Window size ( padded ):  %d ( samples )\n', NS );
fprintf( 'Spectrum size:  %d \n', SPECTRUM_SIZE );
fprintf( 'Window offset when padded:  %d \n', WINDOW_OFFSET );
fprintf( 'Hop during synthesis: %d \n', S_HOP );

plot( BURST_WINDOW );


fprintf( '\n' );

