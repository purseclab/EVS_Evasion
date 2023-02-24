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
sim('light_luminance_Grid.mdl');

comp=[ans.lampLight];
rob = dp_taliro(phi,Pred,comp,ans.tout(:,1));

disp(rob);


% plot(ans.tout,ans.lampLight)
% title('illuminance')


initial_light = 20;

%% TV

TV = [2.9,4.4,1.2];
Monitor = [3.2,3.1,1.3];
Bulb = [4.4, 2.5, 2];

Dist = 1.5;
deg_increase = 45;

ratio = [];
ratios = [];

tic
for alpha = 0:deg_increase:(360-deg_increase)
    for beta = 0:deg_increase:(360-deg_increase)
        for distances = Dist/10:Dist/10:Dist
            mul = [sind(alpha) * cosd(beta), cosd(alpha) * cosd(beta), sind(beta)]; 
            add = distances*mul;
            sensor_pos = TV + add;
            if (sensor_pos(1)<=5 && sensor_pos(2)<=5 && sensor_pos(3)<=3 && sensor_pos(1)>=0 && sensor_pos(2)>=0 && sensor_pos(3)>=0)
                L0Source1=250; %In Lumens, sensor measures in lux.
                timeLightSource=20;
                disLightSource = distances;
                sim('light_luminance_Grid.mdl');
                comp=[ans.lampLight];
                TV_impact = max(comp);

                L0Source1=1200; %In Lumens, sensor measures in lux.
                timeLightSource=20;
                disLightSource = sqrt((sensor_pos(1)-Bulb(1))^2 + (sensor_pos(2)-Bulb(2))^2 + (sensor_pos(3)-Bulb(3))^2);
                sim('light_luminance_Grid.mdl');
                comp=[ans.lampLight];
                Bulb_impact = max(comp);

                L0Source1=150; %In Lumens, sensor measures in lux.
                timeLightSource=20;
                disLightSource = sqrt((sensor_pos(1)-Monitor(1))^2 + (sensor_pos(2)-Monitor(2))^2 + (sensor_pos(3)-Monitor(3))^2);
                sim('light_luminance_Grid.mdl');
                comp=[ans.lampLight];
                Monitor_impact = max(comp);

                ratio = [ratio, (TV_impact/(Bulb_impact+Monitor_impact))];
            else
                ratio = [ratio, 0];
            end
        end
        ratios = [ratios; ratio];
        ratio = [];
    end
end
toc



%% Monitor

TV = [2.9,4.4,1.2];
Monitor = [3.2,3.1,1.3];
Bulb = [4.4, 2.5, 2];

Dist = 1;
deg_increase = 45;

ratio = [];
ratios = [];

tic
for alpha = 0:deg_increase:(360-deg_increase)
    for beta = 0:deg_increase:(360-deg_increase)
        for distances = Dist/10:Dist/10:Dist
            mul = [sind(alpha) * cosd(beta), cosd(alpha) * cosd(beta), sind(beta)]; 
            add = distances*mul;
            sensor_pos = Monitor + add;
            if (sensor_pos(1)<=5 && sensor_pos(2)<=5 && sensor_pos(3)<=3 && sensor_pos(1)>=0 && sensor_pos(2)>=0 && sensor_pos(3)>=0)
                L0Source1=250; %In Lumens, sensor measures in lux.
                timeLightSource=20;
                disLightSource = sqrt((sensor_pos(1)-TV(1))^2 + (sensor_pos(2)-TV(2))^2 + (sensor_pos(3)-TV(3))^2);
                sim('light_luminance_Grid.mdl');
                comp=[ans.lampLight];
                TV_impact = max(comp);

                L0Source1=1200; %In Lumens, sensor measures in lux.
                timeLightSource=20;
                disLightSource = sqrt((sensor_pos(1)-Bulb(1))^2 + (sensor_pos(2)-Bulb(2))^2 + (sensor_pos(3)-Bulb(3))^2);
                sim('light_luminance_Grid.mdl');
                comp=[ans.lampLight];
                Bulb_impact = max(comp);

                L0Source1=150; %In Lumens, sensor measures in lux.
                timeLightSource=20;
                disLightSource = sqrt((sensor_pos(1)-Monitor(1))^2 + (sensor_pos(2)-Monitor(2))^2 + (sensor_pos(3)-Monitor(3))^2);
                sim('light_luminance_Grid.mdl');
                comp=[ans.lampLight];
                Monitor_impact = max(comp);

                ratio = [ratio, (Monitor_impact/(Bulb_impact+TV_impact))];
            else
                ratio = [ratio, 0];
            end
        end
        ratios = [ratios; ratio];
        ratio = [];
    end
end
toc






%% TV - Hospital

TV = [0.2,2,1];
Bulb = [1.8,2.8,1.5];


Dist = 1.3;
deg_increase = 45;

ratio = [];
ratios = [];

tic
for alpha = 0:deg_increase:(360-deg_increase)
    for beta = 0:deg_increase:(360-deg_increase)
        for distances = Dist/10:Dist/10:Dist
            mul = [sind(alpha) * cosd(beta), cosd(alpha) * cosd(beta), sind(beta)]; 
            add = distances*mul;
            sensor_pos = TV + add;
            if (sensor_pos(1)<=3.5 && sensor_pos(2)<=3 && sensor_pos(3)<=3 && sensor_pos(1)>=0 && sensor_pos(2)>=0 && sensor_pos(3)>=0)
                L0Source1=200; %In Lumens, sensor measures in lux.
                timeLightSource=20;
                disLightSource = distances;
                sim('light_luminance_Grid.mdl');
                comp=[ans.lampLight];
                TV_impact = max(comp);

                L0Source1=1000; %In Lumens, sensor measures in lux.
                timeLightSource=20;
                disLightSource = sqrt((sensor_pos(1)-Bulb(1))^2 + (sensor_pos(2)-Bulb(2))^2 + (sensor_pos(3)-Bulb(3))^2);
                sim('light_luminance_Grid.mdl');
                comp=[ans.lampLight];
                Bulb_impact = max(comp);

                ratio = [ratio, (TV_impact/(Bulb_impact))];
            else
                ratio = [ratio, 0];
            end
        end
        ratios = [ratios; ratio];
        ratio = [];
    end
end
toc





