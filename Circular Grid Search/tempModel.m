clear
clc


format long
%Env parameters init
temperatureParametersInitAC;

threshold=1.8; %in Fahrenheit

phi = '[] p';
%phi = ['[]_[0,',num2str(checkTime),'] p'];

i=1;
Pred(i).str = 'p';
Pred(i).A = 1;
Pred(i).b = threshold;


DiffTemp=20/1.8; %change it to other diff temp in Kelvin
timeCoffee=3;   %modify it other time

% [ 1 1 1 0 0 0 0 0 0 0 0 0 0 ]
min=999;


tempInit;    %


%% Fan Mining Hospital
Fan = [1,0.6,1.3];
Heater = [2.4,0.6,0.5];


%Place the sensor with a for loop with different distances and angle
time_window = 5;

Dist = 1.85;
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
                DiffTemp=15/1.8;
                timeCoffee=10;
                dc = sqrt((sensor_pos(1)-Fan(1))^2 + (sensor_pos(2)-Fan(2))^2 + (sensor_pos(3)-Fan(3))^2);
                temperatureParametersInitAC;
                tempInit; 
                sim('temp_Grid.mdl');
                fan_impact = max(AggTemp(1:(length(AggTemp)-1)*time_window/60 +1,1));
                
                
                DiffTemp=20/1.8;
                timeCoffee=10;
                dc = sqrt((sensor_pos(1)-Heater(1))^2 + (sensor_pos(2)-Heater(2))^2 + (sensor_pos(3)-Heater(3))^2);
                temperatureParametersInitAC;
                tempInit; 
                sim('temp_Grid.mdl');
                heater_impact = max(AggTemp(1:(length(AggTemp)-1)*time_window/60 +1,1));
                
                ratio = [ratio, (fan_impact/(heater_impact))];
            else
                ratio = [ratio, 0];
            end
        end
        ratios = [ratios; ratio];
        ratio = [];
    end
end
toc




%% Heater Mining Hospital
Fan = [1,0.6,1.3];
Heater = [2.4,0.6,0.5];


%Place the sensor with a for loop with different distances and angle
time_window = 5;

Dist = 2.03;
deg_increase = 45;

ratio = [];
ratios = [];

tic
for alpha = 0:deg_increase:(360-deg_increase)
    for beta = 0:deg_increase:(360-deg_increase)
        for distances = Dist/10:Dist/10:Dist
            mul = [sind(alpha) * cosd(beta), cosd(alpha) * cosd(beta), sind(beta)]; 
            add = distances*mul;
            sensor_pos = Heater + add;
            if (sensor_pos(1)<=3.5 && sensor_pos(2)<=3 && sensor_pos(3)<=3 && sensor_pos(1)>=0 && sensor_pos(2)>=0 && sensor_pos(3)>=0)
                DiffTemp=15/1.8;
                timeCoffee=10;
                dc = sqrt((sensor_pos(1)-Fan(1))^2 + (sensor_pos(2)-Fan(2))^2 + (sensor_pos(3)-Fan(3))^2);
                temperatureParametersInitAC;
                tempInit; 
                sim('temp_Grid.mdl');
                fan_impact = max(AggTemp(1:(length(AggTemp)-1)*time_window/60 +1,1));
                
                
                DiffTemp=20/1.8;
                timeCoffee=10;
                dc = sqrt((sensor_pos(1)-Heater(1))^2 + (sensor_pos(2)-Heater(2))^2 + (sensor_pos(3)-Heater(3))^2);
                temperatureParametersInitAC;
                tempInit; 
                sim('temp_Grid.mdl');
                heater_impact = max(AggTemp(1:(length(AggTemp)-1)*time_window/60 +1,1));
                
                ratio = [ratio, (heater_impact/(fan_impact))];
            else
                ratio = [ratio, 0];
            end
        end
        ratios = [ratios; ratio];
        ratio = [];
    end
end
toc



