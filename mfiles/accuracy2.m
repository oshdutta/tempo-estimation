%function [acc1,acc2]= accuracy2()
ch1=zeros(length(bpms),1);%for accuracy 2
ch0=zeros(length(bpms),1);%for acc1
chocb=zeros(length(bpms),1);%%for octave error 2/3 or 3/2
choca=zeros(length(bpms),1);%%for octave error 1/2,1/3,2,3
% indeter=zeros(length(bpms),1);
% % mult=bpms./bpm';
% % figure; 
% % stem(bpm,mult);
% ch3=zeros(length(bpms),1);%for pscore
for i=1:1:length(bpm)
    tmp=bpms(i);%dominant tempo1 ground truth
   % tmp2=bpms2(i);%2nd dominant tempo grund truth
% %    if(bpm(i)<71.9)
% %        tt=bpm(i)*2;
% %    elseif(bpm>160)
% %        tt=bpm(i)/2;
% %    else
    tt=bpm(i);
% %    end
% %     tt2=bpm(i,2);
    %1/3
    up1=1.04*(tmp/3);dwn1=0.96*(tmp/3);
    up2=1.04*(tmp/2);dwn2=0.96*(tmp/2);
    up3=1.04*(tmp);dwn3=0.96*(tmp);
     up4=1.04*(tmp*2);dwn4=0.96*(tmp*2);
     up5=1.04*(tmp*3);dwn5=0.96*(tmp*3);
     up6=1.04*(tmp*2/3);dwn6=0.96*(tmp*2/3);
     up7=1.04*(tmp*3/2);dwn7=0.96*(tmp*3/2);
%      up01=1.08*(tmp);dwn01=0.92*(tmp);%mirexPscore
%      up02=1.08*(tmp2);dwn02=0.92*(tmp2);%mirexPscore
   if(tt>=dwn1 && tt<=up1)
       ch1(i)=1;choca(i)=1;
     
    %1/2
   % up2=1.04*(tmp/2);dwn2=0.96*(tmp/2);
    elseif(tt>=dwn2 && tt<=up2)
      ch1(i)=1;choca(i)=1;
    
    %1
   % up3=1.04*(tmp);dwn3=0.96*(tmp);
    elseif(tt>=dwn3 && tt<=up3)
      ch1(i)=1;
      ch0(i)=1;
    %2
   % up4=1.04*(tmp*2);dwn4=0.96*(tmp*2);
    elseif(tt>=dwn4 && tt<=up4)
     ch1(i)=1;choca(i)=1;
    
    %3
%     up5=1.04*(tmp*3);dwn5=0.96*(tmp*3);
    elseif(tt>=dwn5 && tt<=up5)
      ch1(i)=1;choca(i)=1;
     elseif((tt>=dwn6 && tt<=up6) || (tt>=dwn7 && tt<=up7))
      chocb(i)=1;
% %    elseif(flg(i)==-1)
% %     indeter(i)=1;
   end 
%    if((tt>=dwn01 && tt<=up01)&& (tt2>=dwn02 && tt2<=up02))
%        ch3(i)=1*0.9 + 0.1;
%    elseif((tt>=dwn01 && tt<=up01))
%         ch3(i)=1*0.9;
%    elseif((tt2>=dwn02 && tt2<=up02))
%        ch3(i)= 0.1;
%   end

 end
acc1=sum(ch0)*100/length(bpm)%not for mirex
%acc1=sum(ch0)*100/99;
%pscore=sum(ch3)/length(bpms);
acc2=sum(ch1)*100/length(bpm)
%acc2=sum(ch1)*100/99;
octa=sum(choca)*100/length(bpm)
octb=sum(chocb)*100/length(bpm)
% octa=sum(choca)*100/99;
% octb=sum(chocb)*100/99;
% ind=sum(indeter);% number of confusing tempo estimates
%end