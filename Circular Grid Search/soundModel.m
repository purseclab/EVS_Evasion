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
sim('sound_Grid.mdl');
rob = dp_taliro(phi,Pred,ans.sound(:,1),ans.tout(:,1));
disp(rob);

soundLevel = ans.sound;

aggregated = 10*log10(10^(initialSound/10) + 10.^(soundLevel/10));



%% FAN-Hospital CIRCULAR GRID SEARCH.

TV = [0.2,2,1];
Alarm = [2.6,1.7,1.2];
Fan = [1,0.6,1.3];
Heater = [2.4,0.6,0.5];

Dist = 1.9;
deg_increase = 45;

ratio = [];
ratios = [];

tic
for alpha = 0:deg_increase:(360-deg_increase)
    for beta = 0:deg_increase:(360-deg_increase)
        for distances = Dist/10:Dist/10:Dist
            mul = [sind(alpha) * cosd(beta), cosd(alpha) * cosd(beta), sind(beta)]; 
            add = distances*mul;
            sensor_pos = Fan + add;
            if (sensor_pos(1)<=3.5 && sensor_pos(2)<=3 && sensor_pos(3)<=3 && sensor_pos(1)>=0 && sensor_pos(2)>=0 && sensor_pos(3)>=0)
                amplitude = 55;
                timeSoundSource=0.1;
                dis = sqrt((sensor_pos(1)-TV(1))^2 + (sensor_pos(2)-TV(2))^2 + (sensor_pos(3)-TV(3))^2);
                soundInit;
                sim('sound_Grid.mdl');
                soundLevel = ans.sound;
                TV_impact = max(soundLevel);

                amplitude = 65;
                timeSoundSource=60;
                dis = sqrt((sensor_pos(1)-Alarm(1))^2 + (sensor_pos(2)-Alarm(2))^2 + (sensor_pos(3)-Alarm(3))^2);
                soundInit;
                sim('sound_Grid.mdl');
                soundLevel = ans.sound;
                Alarm_impact = max(soundLevel);
                
                amplitude = 61;
                timeSoundSource=60;
                dis = sqrt((sensor_pos(1)-Fan(1))^2 + (sensor_pos(2)-Fan(2))^2 + (sensor_pos(3)-Fan(3))^2);
                soundInit;
                sim('sound_Grid.mdl');
                soundLevel = ans.sound;
                Fan_impact = max(soundLevel);
                
                amplitude = 52;
                timeSoundSource=60;
                dis = sqrt((sensor_pos(1)-Heater(1))^2 + (sensor_pos(2)-Heater(2))^2 + (sensor_pos(3)-Heater(3))^2);
                soundInit;
                sim('sound_Grid.mdl');
                soundLevel = ans.sound;
                Heater_impact = max(soundLevel);
                
                ratio = [ratio, (Fan_impact - (10*log10(10^(TV_impact/10) + 10.^(Alarm_impact/10) + 10.^(Heater_impact/10))))];
            else
                ratio = [ratio, 0];
            end
        end
        ratios = [ratios; ratio];
        ratio = [];
    end
end
toc




%% TV-Hospital CIRCULAR GRID SEARCH.

TV = [0.2,2,1];
Alarm = [2.6,1.7,1.2];
Fan = [1,0.6,1.3];
Heater = [2.4,0.6,0.5];

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
            sensor_pos = TV + add;
            if (sensor_pos(1)<=3.5 && sensor_pos(2)<=3 && sensor_pos(3)<=3 && sensor_pos(1)>=0 && sensor_pos(2)>=0 && sensor_pos(3)>=0)
                amplitude = 55;
                timeSoundSource=0.1;
                dis = sqrt((sensor_pos(1)-TV(1))^2 + (sensor_pos(2)-TV(2))^2 + (sensor_pos(3)-TV(3))^2);
                soundInit;
                sim('sound_Grid.mdl');
                soundLevel = ans.sound;
                TV_impact = max(soundLevel);

                amplitude = 65;
                timeSoundSource=60;
                dis = sqrt((sensor_pos(1)-Alarm(1))^2 + (sensor_pos(2)-Alarm(2))^2 + (sensor_pos(3)-Alarm(3))^2);
                soundInit;
                sim('sound_Grid.mdl');
                soundLevel = ans.sound;
                Alarm_impact = max(soundLevel);
                
                amplitude = 61;
                timeSoundSource=60;
                dis = sqrt((sensor_pos(1)-Fan(1))^2 + (sensor_pos(2)-Fan(2))^2 + (sensor_pos(3)-Fan(3))^2);
                soundInit;
                sim('sound_Grid.mdl');
                soundLevel = ans.sound;
                Fan_impact = max(soundLevel);
                
                amplitude = 52;
                timeSoundSource=60;
                dis = sqrt((sensor_pos(1)-Heater(1))^2 + (sensor_pos(2)-Heater(2))^2 + (sensor_pos(3)-Heater(3))^2);
                soundInit;
                sim('sound_Grid.mdl');
                soundLevel = ans.sound;
                Heater_impact = max(soundLevel);
                
                ratio = [ratio, (TV_impact - (10*log10(10^(Fan_impact/10) + 10.^(Alarm_impact/10) + 10.^(Heater_impact/10))))];
            else
                ratio = [ratio, 0];
            end
        end
        ratios = [ratios; ratio];
        ratio = [];
    end
end
toc














