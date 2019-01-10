 function bpm= mainFunc2(filename)
%function for getting tempo for datasets
clc;clear all; close all;
 %tstart=tic

%   [W,FS]=audioread(filename);
[W,FS]=audioread('MARSYAS_DATADIR\ballroom\ChaChaCha\Albums-Cafe_Paradiso-08.wav');
    %%num_samples=length(W);
   % online=0;%%false
    frame_size=2048;
   % loga=1;
    fps=200;
    hop_size=ceil(FS/fps);%221 samples/frame for FS=44100, 110.5 samples/frame for Fs=22050
    %%normalize,downmix audio
     W1=waveclass(W,FS,0,0);
     %num_fft_bins=1024;
     start=0*FS;
      maxfr=6;%30ms*200fps
     pravgfr=20;%frames=100ms*200fps
     poavgfr=14;%frames=70m*200fps
     cmbfr=6;%30ms*200fps
    % stop=28*FS;%seconds worth of samples
     %num_samples=10*FS;%seconds %%worth of samples
     %num_fft_bins=1024;
     %%calculate the spectrogram by doing STFT
  [sp]=spectro(W,FS);
     nfft =size(sp,1);
%      num_frames = size(sp,2);
  % [S,F,T,~]= spectrogram(W1(start+1:end),2048,(frame_size-hop_size),2047,FS,'yaxis');
   %%filter at 16000Hz
% %    zf=1:length(F);
% %    f16h=max(zf'.*(F(zf)<16000));
% %    Sn=S(1:f16h,:);
   %median filtering
% %     r=1:length(F);
%%logsp=(log(1+(1000.*abs(Sn))));
% %  S1(r,:)= medfilt1(abs(S(r,:)),75);
%%filterbank
 %%[filterbank,~]=FilterClass(1024,FS,F(2),F(1024));
%% [filterbank,~]=FilterClass(1024,FS,F(2),F(f16h));  
% [filterbank,~]=FilterClass(f16h,FS,27.5,16000);  
[filterbank,~]=FilterClass(nfft,FS,27.5,16000);  
 Sfil=filterbank'*sp;
% %  Sfil=filterbank'*abs(Sn);
   %%   Sfil=filterbank'*(abs(Sn));
      
% %    %diff of frames
   diff_frames=2;%seen to give best performance
 %%  sodf=SpecODF(S,diff_frames);
   ons=SpecODF(Sfil,diff_frames);
   i=1:1:length(ons);
% %     ons(i)=sum(sodf(:,i));
    ons(1:1)=0;%changed
% %     figure;plot(i,ons);
     his=combfilter(ons,fps);
   %  ons(i)=sum(spsdm(:,i));
 %  ons(i)=sum(sodf(:,i));
   % %     hm1=hamming(28);
% % ons1=conv(ons,hm1,'same');
% %    ipr=0;
% %  ons_ext=[zeros(1,pravgfr) ons zeros(1,poavgfr)];%zero padding
% %  ons1=zeros(1,length(T));
% %  for i=1:1:length(T)
% % ons1(i)=ons(i)*((ons(i)>=mean(ons_ext(i:i+(poavgfr+pravgfr)))) && ((i-ipr)>cmbfr));%50 tunable
% % ipr=i*(ons1(i)>0);
% % %max(ons(i-maxfr:i+maxfr)))&&
% %  end
%%smoothing
  % cmb=combfilter(ons,fps);
  % his=combfilter(ons,fps);
% %     tau=40:1:250;
% %     %ti=1:1:length(ons);
% %     %histo
% %     his=zeros(length(tau),1);
% %     clear S; clear T;
% %      %disp('Building histogram');
% %     for j=1:1:length(tau)
% %         s=0;
% %     for i=1:length(ons)
% %        [~,arg]=max(cmb(:,i));
% %        if j==arg
% %            s=s+cmb(j,i);
% %        end
% %     end
% %     his(j)=s;
% %     end
% %     % 
    %%smoothen histogram
    tau=40:1:250;
%     len=48:1:300;
    hm=hamming(7);
    hism=conv(his,hm,'same');
    figure;
    subplot(211)
    plot(tau,his);
    subplot(212);
    plot(tau,hism);title('smoothened histogram of tempo');xlabel('Tempo(BPM)');ylabel('no. of frames');
   % [~,tempo1]=max(hism);%1st tempo
   [~,tempo1]=max(hism);
   %features = info_histogram(tempo1, hism, 10, tempo1+40);
  % bpm=(60*fps)/(47+tempo1);
  bpm=40+tempo1
%    [~,tempo1]=max(his);
   % [~,tempo2]=max(hism(hism<max(hism)));%2nd tempo
     %disp((tempo+40));
%      %local peaks
% % MPH=(max(hism))*0.98;
% % pks=findpeaks(hism,'MinPeakHeight',MPH);
% % if(length(pks)>1)
% % flg=-1;
% % else
% %     flg=0;
% % end
% % [pks,Locpeaks]=findpeaks(hism);
% % pk=pks.*(pks>(0.80*mx));%thresholding peaks
% % LocpeaksTh=Locpeaks.*(pk>0);
   %bpm=tempo1+40;
   %  bpm(2)=tempo2+40;
% %    if(bpm(1)<65)
% %        twb=bpm(1)*2;
% %        %find local peak
% %        twbm=locpeak(twb,hism);
% %        mb=hism(twbm);
% %        if((0.55*hism(tempo1))<mb)%65%of max is taken arbitrarily
% %            bpm(1)=twbm+40;
% %        end
% %   elseif(bpm(1)<110)%good for balroom perception of tempo
% %      bpm(1)=max(LocpeaksTh)+40;
% %    end
  %telapsed=toc(tstart) 
   end