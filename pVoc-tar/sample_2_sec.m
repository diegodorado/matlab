function  sec = sample_2_sec( sample_no )

%  Converts sample no. to time from the start of the sound.
%
%      13.3.03, pm-n.

globals;

sec = ( sample_no - 1 )/FS;
