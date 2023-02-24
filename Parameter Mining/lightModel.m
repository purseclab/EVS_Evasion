clear
clc

fixedStep=0.5/60;

%Env parameters init
startLightSource=0;
timeLightSource=20;
L0Source1=200; %In Lumens, sensor measures in lux.

disLightSource=0.65;

threshold=5;

phi = '[] p';
%phi = ['[]_[0,',num2str(checkTime),'] p'];

i=1;
Pred(i).str = 'p';
Pred(i).A = [1];
Pred(i).b = threshold;


% sim('tempModel.mdl');
sim('light_luminance.mdl');

comp=[ans.lampLight];
rob = dp_taliro(phi,Pred,comp,ans.tout(:,1));

disp(rob);


% plot(ans.tout,ans.lampLight)
% title('illuminance')


initial_light = 20;

%%


disLightSource = 10;
l = 0.0;
r = 10.0;
timeLightSource=20;
L0Source1=1200; %In Lumens, sensor measures in lux.

tic
while l < r
    disLightSource = (l+r)/2;
    sim('light_luminance.mdl');
    comp=[ans.lampLight];
    rob = dp_taliro(phi,Pred,comp,ans.tout(:,1));
    if rob > 0.001
        r = disLightSource;
    elseif rob < -0.001
        l = disLightSource;
    else
        break
    end
    if l+0.1>r
        break
    end
    disp(rob)
end

toc
