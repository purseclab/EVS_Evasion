clear
clc

fixedStep=0.5/60;

dis=3;
amplitude = 55;

soundInit;
initialSound = 40;

%Env parameters init
startSoundSource=0;
timeSoundSource=5;


% LTL threshold
threshold=50;


phi = '[] p';
%phi = ['[]_[0,',num2str(checkTime),'] p'];

i=1;
Pred(i).str = 'p';
Pred(i).A = 1;
Pred(i).b = threshold;

   % sim('tempModel.mdl');
sim('sound.mdl');
rob = dp_taliro(phi,Pred,ans.sound(:,1),ans.tout(:,1));
disp(rob);

soundLevel = ans.sound;

aggregated = 10*log10(10^(initialSound/10) + 10.^(soundLevel/10));

%    subplot(2,1,1)
%plot(ans.tout,ans.soundSourceOn);
%title('garbageDisposal')
% grid on
% subplot(2,1,2)
% plot(ans.tout,ans.sound)
% title('sound')
% grid on
 
%%
dis = 10;
l = 0.0;
r = 10.0;
amplitude = 55;

tic
while l < r
    dis = (l+r)/2;
    soundInit;
    sim('sound.mdl');
    rob = dp_taliro(phi,Pred,ans.sound(:,1),ans.tout(:,1));
    if rob > 0.001
        r = dis;
    elseif rob < -0.001
        l = dis;
    else
        break
    end
    if l+0.1>r
        break
    end
    disp(rob)
end

toc

