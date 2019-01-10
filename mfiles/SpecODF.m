function ons= SpecODF(spec,diff_frames)
%%The SpectralODF class implements most of the common onset detection function based on the magnitude or phase information of a spectrogram.
% % ratio=0.5;
% % max_bins=3;
% % diff_frames=0;
% % temporal_filter=3;
% % temporal_origin=0;
% Creates a new ODF object instance.close all
% 
%         :param spectrogram:     a Spectrogram object on which the detection
%                                 functions operate
%         :param ratio:           calculate the difference to the frame which
%                                 has the given magnitude ratio
%         :param max_bins:        number of bins for the maximum filter
%         :param diff_frames:     calculate the difference to the N-th previous
%                                 frame
%         :param temporal_filter: temporal maximum filtering of the local group
%                                 delay for the ComplexFlux algorithms
%         :param temporal_origin: origin of the temporal maximum filter
% 
%         If no diff_frames are given, they are calculated automatically based on
%         the given ratio.

%% determine the number of diff frames
%         if diff_frames==0
%             %%get the first sample with a higher magnitude than given ratio
%             for i=1:length(spec)
%                 if spec(i)>ratio
%                   sample = i;
%                   break;
%                 end
%             end
%             diff_samples = length(spec) / 2 - sample;
%             %% convert to frames
%             diff_frames = uint32(round(diff_samples / hop_size));
%             %%set the minimum to 1
%             if diff_frames < 1
%                 diff_frames = 1;
%             end
%         end
% %        Calculate the difference spec used for SuperFlux.
% % 
% %         :param spec:        magnitude spectrogram
% %         :param diff_frames: calculate the difference to the N-th previous frame
% %         :param max_bins:    number of neighboring bins used for maximum
% %                             filtering
% %         :return:            difference spectrogram used for SuperFlux
% % 
% %         Note: If 'max_bins' is greater than 0, a maximum filter of this size
% %               is applied in the frequency direction. The difference of the
% %               k-th frequency bin of the magnitude spectrogram is then
% %               calculated relative to the maximum over m bins of the N-th
% %               previous frame (e.g. m=3: k-1, k, k+1).
% % 
% %               This method works only properly if the number of bands for the
% %               filterbank is chosen carefully. A values of 24 (i.e. quarter-tone
% %               resolution) usually yields good results.
        %% init diff matrix
        col=size(spec);%after using spectrogram(), rows are frequency bins and coloumns is time
       % diff_spec = zeros(col(2),1);
        diffs=zeros(col(1),col(2));
        if diff_frames < 1
           diff_frames=1;
        end
        %% widen the spectrogram in frequency dimension by `max_bins`
        %max_spec = maximum_filter(spec, max_bins);%%%????..corrected
        %% calculate the diff
        %%max_spec=padarray(max_spec1,double(diff_frames));
        logsp=log(1+(1000.*(spec)));%logarithmic magnitude
      % logsp=log(1+(1000.*spec));
     %% logsp=spec;
        i=1:1:col(2)-diff_frames;
        id=diff_frames+1:1:col(2);
       % for i=1:col(2)
          for j=2:col(1)-1 %difference and half rectification 
              
                 % temp=spec(j,i) - max_spec(j,i-diff_frames);
                 % temp=abs(spec(j,i)) -abs(spec(j,i-diff_frames));
                 temp=(abs(logsp(j,id)) -abs(max(logsp(j-1:j+1,i))));%%is
                %not working because the frequency scale is not
                 %logarithmic.
               % temp=(abs(logsp(j,id)) -abs(logsp(j,i)));
                   diffs(j,id)=temp.*(temp>0);  
                 % diff_spec(i) = diff_spec(i)+temp;%%????correct it.corrected
                 temp=logsp(j,1:diff_frames);
                 diffs(j,1:diff_frames)=temp.*(temp>0);
                 
                  %diff_spec(i)=diff_spec(i)+ ((temp+abs(temp))/2);
          end
           i=1:1:col(2);
    ons(i)=sum(diffs(:,i));
       % end
        %%keep only positive values
%            if diff_spec(i)<0
%                 diff_spec(i)=0;  
%             end
             % diff_spec(i)=sum(diffs(:,i));
       % end
         %%omit LGD mask
        %%sum all positive 1st order max. filtered differences
       % sumd=zeros(col(1),1);
% %         for j=1:col(1)
% %        for i=1:col(2)
% %         sumd(j)=sumd(j) + diff_spec(j,i);
% %        end
% %         end
       %% disp('done');
        %%superfluxFunction
        %spectrogram display
%         figure;
%      surf(t,f,abs(diffs),'EdgeColor','none');colormap(jet);axis xy; axis tight;
end