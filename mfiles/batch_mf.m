clc; close all; clear all;
collections = {
  %'acm_mirum_tempos.mf'
   % 'ballroom_tempos.mf'
   % 'genres_tempos.mf'
   % 'ismir2004_songs_tempos.mf'
    'hains_tempos.mf'
   % 'mir6_tempos.mf'
  % 'smc_mirum_tempos.mf'
  %
    };
md = 'MARSYAS_DATADIR';
%changed from length(collections) to 5
for coll_index = 1:length(collections)
	coll_name = collections(coll_index);
	coll = char(strcat(md,'\', coll_name));
	%coll = "foo.mf";
	fid = fopen(coll,'r');
	j = 1;
	wavs = {};
	bpms = zeros();
   % bpms2 = zeros();
  
	while not(feof(fid))
  % while(j<=1000)
% %        at=' ';a='';aend=' ';%%for ismirsongs
% %       while(~(strcmp(aend,'wav')))
% %           at=fscanf(fid, '%c',1);
% %           a=cat(2,a,at);
% %           if(at=='.')
% %               aend=fscanf(fid,'%c',3);
% %            a=cat(2,a,aend);
% %           end
% %       end
    
   a=fscanf(fid, '%s\t',1);
		wavs(j) = {a};
		a1 = fscanf(fid, '%f');
       
        bpms(j)=a1;
      %  bpms2(j)=a1(2);%for mirex
	%	j = j+ 1;%%for ismirsongs
       % disp('m');
	 end
 	fclose(fid);

	outfile = coll(1:end-3);
	%outfile = strrep(outfile, md, '');
	outfile = strcat(outfile, '-mar-matlab.mf');
	fout = fopen(outfile, 'w');
    bpm=zeros(length(wavs),1);
   % flg=zeros(length(wavs),1);
    % bpm=zeros(length(wavs),2);%for getting 2 dominant tempos
   % clear fid;
    % ch=zeros(length(bpm),1);
    %b=zeros(100,3);
  for i = 1:length(wavs)
        wav = char(wavs(i));
         wav = strrep(wav, 'MARSYAS_DATADIR', md);
		%bpm_ground = bpms(i);
        b=mainFunc2(wav);
% %         b(i,:)= b1';
        
        bpm(i,:)=b;
         %bpm(i)=b(i,3);
        % flg(i)=fl;
       % fprintf(fout, '%s\t%f\n', wav, b);
		%fprintf(fout, '%s\t%f\n', wav, b(1),b(2));%for mirex
        %up=1.04*bpms(i);dwn=0.96*bpms(i);%4% about ground truth
        %ch(i)=1*(b>=dwn && b<=up);
		%sprintf('Completed file %i / %i\n', i, length(wavs));
        disp(i);
		%fflush(fid);
  end
     
    
        
      
      
           
	
	fclose(fout);
%  acc=sum(ch)*100/length(wavs)
end

%[acc1,acc2]=accuracy2()
