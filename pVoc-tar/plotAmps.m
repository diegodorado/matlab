function   plotAmps(amp1, firstFreq, lastFreq, scale, amp2 )

%     The parameters  'scale' and 'amp2' are optional.
%
%     31.3.03, pm-n.

globals;

binWidth = FS/(2*SPECTRUM_SIZE-2);

if nargin == 1

  firstBin = 1;
  lastBin = SPECTRUM_SIZE;

else

  firstBin = floor( firstFreq/binWidth ) + 1;
  if firstBin < 1
    firstBin = 1;
  end;

  lastBin = ceil( lastFreq/binWidth ) + 1;
  if lastBin > SPECTRUM_SIZE
    lastBin = SPECTRUM_SIZE;
  end;

end;

x = [firstBin-1:lastBin-1]*binWidth;

figure;

if nargin < 4
  plot( x, amp1(firstBin:lastBin), '-rs' );
else
  if strcmp( scale, 'loglog' )
   loglog( x, amp1(firstBin:lastBin), '-rs' );
  elseif strcmp( scale, 'semilogx' )
   semilogx( x, amp1(firstBin:lastBin), '-rs' );
  elseif strcmp( scale, 'semilogy' )
   semilogy( x, amp1(firstBin:lastBin), '-rs' );
  else
   plot( x, amp1(firstBin:lastBin), '-rs' );
  end;
end;


xlabel('Hz');
ylabel('Amp.');
title('Amplitudes');
grid on;

if nargin == 5

  hold on;

  if strcmp( scale, 'loglog' )
   loglog( x, amp2(firstBin:lastBin), '-bs' );
  elseif strcmp( scale, 'semilogx' )
   semilogx( x, amp2(firstBin:lastBin), '-bs' );
  elseif strcmp( scale, 'semilogy' )
   semilogy( x, amp2(firstBin:lastBin), '-bs' );
  else
   plot( x, amp2(firstBin:lastBin), '-bs' );
  end;

  title('Amplitudes: amp1 (red), amp2 (blue)' );
end;





















