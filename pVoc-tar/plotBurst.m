function  plotBurst( Burst, first_in_burst, last_in_burst )

%
%  Plots the sample values versus the sample no. 
%  The parameters first_in_burst and last_in_burst are optional.
%
%  plotBurst( Burst ) : Plots the entire burst.
%  plotBurst( Burst, first_in_burst ) : Plots the first 
%    'first_in_burst' samples of the burst.
%  plotBurst( Burst, first_in_burst, last_in_burst ) : Plots
%    from 'first_in_burst' to 'last_in_burst'.
%
%     31.3.03, pm-n.

[ n, ch ] = size( Burst.buffer );

if nargin == 1

  first_i = 1;
  last_i = n;

elseif nargin == 2

  first_i = 1;
  last_i = first_in_burst;

elseif nargin == 3

  first_i = first_in_burst;
  last_i = last_in_burst;

else
  error( ' Wrong no. of parameters ( plotBurst )' );

end;

if last_i > n
     last_i = n;
end;

xx = [ Burst.first + first_i - 1 : Burst.first + last_i - 1 ];

if ch == 1

  figure;

  plot( xx, Burst.buffer( first_i : last_i ) );

  title( 'Sample values vs. sample no.' );
  xlabel( 'Sample no.' );

else

  figure;

  plot( xx, Burst.buffer( first_i : last_i, 1 ) );

  title( 'Sample values vs. sample no.( ch. 1 )' );
  xlabel( 'Sample no.' );

  figure;

  plot( xx, Burst.buffer( first_i : last_i, 2 ) );

  title( 'Sample values vs. sample no. ( ch. 2 )' );
  xlabel( 'Sample no.' );

end;

grid on;

