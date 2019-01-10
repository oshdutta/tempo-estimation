function [fftabs_reduced, num_fft] = spectro(wav_data, wav_sr)
WINDOWSIZE=2048;
  %  fps=200;
    HOPSIZE=221;
   % HOPSIZE=ceil(wav_sr/fps);%221
    num_ticks = int32(length(wav_data) / (HOPSIZE*221)) - 1;

extra_zeros = zeros(1, WINDOWSIZE - HOPSIZE);
padded = [extra_zeros wav_data'];


%%% 1) Overlap: create overlapped signal
buffered = buffer(padded, WINDOWSIZE, WINDOWSIZE-HOPSIZE, 'nodelay');
%oss_sr = wav_sr / HOPSIZE;
% only include complete buffers
buffered = buffered(:,1:num_ticks*HOPSIZE);
%%% 2) Log Power Spectrum: windowing and log-magnitude spectrum
% match Marsyas hamming window
ns = 0:WINDOWSIZE-1;
hamm = 0.54 - 0.46 * cos( 2*pi*ns / (WINDOWSIZE-1));

windows = diag(hamm) * buffered;

fft_res = fft(windows);
fftabs = abs(fft_res);
fftabs_reduced = fftabs(1:WINDOWSIZE/2+1,:) / WINDOWSIZE;
%logmag = log(1+1000*fftabs_reduced);

%num_fft = size(logmag, 1);
%num_frames = size(logmag, 2);
 %figure;
%  surf(T,F,logsp,'edgecolor','none'); axis tight;
% view(0,90);
% xlabel('Time (Seconds)'); ylabel('Hz');title('Log Spectrum audio');
end

    