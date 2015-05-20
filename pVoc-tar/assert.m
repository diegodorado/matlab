function  assert( val1, requirement, val2 )

%  The two values, val1 and val2 are inspected and possibly compared
% depending on requirement, which is a string.

%      27.3.03, pm-n.


globals;

if strcmp( requirement, 'intGT' )  % val1 is an interger greater than val2

  if ~( ( val1 > val2 ) & ( round( val1 ) == val1 ) )
    error( 'Illegal value ( assert - intGT )' );
  end;


else

  error( 'Unknown requirement ( assert )' );

end;

