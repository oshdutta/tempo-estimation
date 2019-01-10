function his= combfilter(ons,fps)

al=0.79;
%al=0.89;
%al=1;
%al=0.65;
bpmmax=250;bpmmin=40;
% bppmin=48; bppmax=300;
% len=bppmax-bppmin+1;
% % tmax=60*fps/bpmmin;
% % tmin=60*fps/bpmmax;
cmb=zeros((bpmmax-bpmmin+1),length(ons));
for i=bpmmin:1:bpmmax
    tl=round(60*fps/i);
%     tl=i;
    for n=1:length(ons)
    if (n-tl)<1
    cmbpv=0;
    else
       % cmbpv=cmb((i-39),(n-tl));
       cmbpv=cmb((i-bpmmin+1),(n-tl));
       
    end
     % cmb((i-39),n)=ons(n)+(al.*cmbpv);
     cmb((i-bpmmin+1),n)=ons(n)+(al.*cmbpv);
    end
end
tau=40:1:250;
T=1:1:length(ons);
%  figure;
% surf(T,tau,cmb,'edgecolor','none'); axis tight; 
% view(0,90);
% xlabel('Time (frames)'); ylabel('Tempo'); title('comb filter output');
% % figure;
% % subplot(211)
% % plot(T,cmb(89,:));xlabel('time frames'); ylabel('magnitude');title('Comb filter output for 65 BPM');
% % subplot(212)
% % plot(T,cmb(40,:));xlabel('time frames'); ylabel('magnitude');title('Comb filter output for 80 BPM');
% %    
his=zeros((bpmmax-bpmmin+1),1);
for j=1:1:length(tau)
        s=0;
    for i=1:length(ons)
       [~,arg]=max(cmb(:,i));
       if j==arg
           s=s+(cmb(j,i));%trying square maginutde
       end
    end
    his(j)=s;
 end


end