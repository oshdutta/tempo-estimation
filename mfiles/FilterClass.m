%%FilterClass
function [filtbank,frequ] = FilterClass(num_fft_bins,FS,fm,fm2)
%samplerate
%%num_fft bins is the length of F vector..here 1024
%%clc; clear all; close all;
% % clc; close all; clear all;
% %  num_fft_bins=1024;
% %  FS=44100;
% %  fm=27.5;fm2=16000;
fmax=fm2;
% % fmin=fm;fmax=fm2;
bands=24;%originally 12
fmin=fm;
if fmax>FS %reduce fmax is more than FS
    fmax=FS/2;
end
%get the list of frequencies..aligned in a log scale
fac=2.0^(1.0/bands);
a=440;
freq=a;
freqL=freq;
%go upwards till fmax
while freq <= fmax
            %multiply once more, since the included frequency is a frequency
            % which is only used as the right corner of a (triangular) filter
            freq=freq * fac;
            freqL=[freqL,freq];
            
end
% restart with a and go downwards till fmin
freq=a;
%sorting is happening below*******
while freq >= fmin
            %multiply once more, since the included frequency is a frequency
            % which is only used as the right corner of a (triangular) filter
            freq=freq / fac;
            freqL=[freq,freqL];
end
%sort
%%freqLi=sort(freqL);
% % figure;
% % plot(freqLi);
%conversion factor for mapping of frequencies to spectrogram bins
 factor = (FS/ 2.0) / num_fft_bins;
 %factor=fm2/num_fft_bins;
% map the frequencies to the spectrogram bins
FreqL=uint32(round(freqL./factor));%convert to integer
%keep only unique bins and auto sorting
FreqList=unique(FreqL);
%filter out all frequencies outside the valid range
frequ=[1];%changed from 0

        
%%frequ=FreqList(1);
for i=1:length(FreqList) 
    f=FreqList(i);
     if f<num_fft_bins
       frequ= [frequ, f] ;
    end
end
% number of bands
  totbands = length(frequ) - 2;%%or 3?
  if totbands<3
      disp('cannot create freq filter with < 3 bands');
  end
  %creat filterbank with float values
  filtbank=zeros(num_fft_bins,totbands);
  %Make Triangular Filter
  for i=1:totbands
  start=frequ(i);
  mid=frequ(i+1);
  stop=frequ(i+2);%+3??
  %%height of the filter
       height = 1.0;
        %%normalize the height
       % tfilt=zeros(stop-start);
    %  height = 2/ (stop - start);%%??
       rais=linspace(0.0,double(height),((mid-start)));%%raising edge
       fall = linspace(double(height), 0, (stop - mid));
       tfilt=[rais,fall];
       filtbank(start:stop-1,i) =  tfilt;
  end
% %   s=size(filtbank);
% %   figure;
% %   surf(1:s(2),1:s(1),filtbank,'edgecolor','none'); axis tight; %plottong the PSD
% % %% surf(T,F,sodf,'edgecolor','none'); axis tight;
% % view(0,90);
% % xlabel('Time (Seconds)'); ylabel('Hz');title('Filterbank');
end