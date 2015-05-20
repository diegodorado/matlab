function  ampOut = pitchWarp( ampIn, map )

%  The amp. spectrum in ampIn is warped into ampOut according to 'map'
%  so that the frequency map(1,:) in ampIn corresponds to frequency
%  map(2,:) in ampOut.

%      8.4.03, pm-n.

globals;

fftsize = 2*SPECTRUM_SIZE-2;

[mapR, mapC] = size(map);
mapL = zeros( mapR+2, mapC );
mapL(2:mapR+1,:) = map;
mapL(1,:) = [0, 0];
mapL(mapR+2,:) = [FS/2, FS/2];



fCenter = [0:SPECTRUM_SIZE-1]'*fs/fftsize;

fTilde = interp1(mapL(:,2), mapL(:,1), fCenter, 'linear');

ampOut = interp1(fCenter, ampIn, fTilde, 'linear');

