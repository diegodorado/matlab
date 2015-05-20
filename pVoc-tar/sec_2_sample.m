function  sample_no = sec_2_sample( sec )

%  Converts time ( in sec. from the start of the sound ) to sample no.
%
%     13.3.03, pm-n

globals;

sample_no = round( sec * FS ) + 1;

