%% 5m x 5m x 3m

Lock = [3.5,0.1,1];
AC = [2.5,1.7,2.4];
TV = [2.9,4.4,1.2];
Monitor = [3.2,3.1,1.3];
Toaster = [4.6,1.9,1.1];
Bulb = [4.4, 2.5, 2];
Heater = [2, 4.4, 0.5];
ActuatorsHome = [Lock; AC; TV; Monitor; Toaster; Bulb; Heater];

a1 = [4.3,0.5,1];
a2 = [2.3,3.4,1.3];
a3 = [3.8,4.6,1.5];
a4 = [1.4,4.6,0.7];
b1 = [3.4,4.1,1.5];
b2 = [2.7,3.5,1.3];
b3 = [4.6,1.4,1.2];
c1 = [2,3.2,1.3];
c2 = [3.2,1.8,1.5];
SensorsHome = [a1; a2; a3; a4; b1; b2; b3; c1; c2];

% actuator1 = [5, 2.6, 1.1]; %Sensor a2 New;
% actuator1 = [3, 0.8, 1]; %Sensor a1 New;


% actuator1 = ActuatorsHome(6,:);

actuator2 = ActuatorsHome(5,:);
dis = sqrt((actuator1(1)-actuator2(1))^2 + (actuator1(2)-actuator2(2))^2 + (actuator1(3)-actuator2(3))^2);

%% TV
% b2_new;
mul = [sind(45) * cosd(270), cosd(45) * cosd(270), sind(270),]; 
add = 0.5*1.5*mul;
b2_new = TV + add;

TV_dist = sqrt((TV(1)-b2_new(1))^2 + (TV(2)-b2_new(2))^2 + (TV(3)-b2_new(3))^2); %0.75
Monitor_dist = sqrt((Monitor(1)-b2_new(1))^2 + (Monitor(2)-b2_new(2))^2 + (Monitor(3)-b2_new(3))^2); %1.6
Bulb_dist = sqrt((Bulb(1)-b2_new(1))^2 + (Bulb(2)-b2_new(2))^2 + (Bulb(3)-b2_new(3))^2); %2.9

%% Monitor
% b1_new;
mul = [sind(90) * cosd(225), cosd(90) * cosd(225), sind(225)]; 
add = 0.4*mul;
b1_new = Monitor + add;

TV_dist = sqrt((TV(1)-b1_new(1))^2 + (TV(2)-b1_new(2))^2 + (TV(3)-b1_new(3))^2); %1.3
Monitor_dist = sqrt((Monitor(1)-b1_new(1))^2 + (Monitor(2)-b1_new(2))^2 + (Monitor(3)-b1_new(3))^2); %0.4
Bulb_dist = sqrt((Bulb(1)-b1_new(1))^2 + (Bulb(2)-b1_new(2))^2 + (Bulb(3)-b1_new(3))^2); %1.9


%%

dist = [];
Homedistances = [];
for i = 1:1:7
    actuator = ActuatorsHome(i,:);
    for j = 1:1:9
        sensor = SensorsHome(j,:);
        % Compute distance
        dis = sqrt((sensor(1)-actuator(1))^2 + (sensor(2)-actuator(2))^2 + (sensor(3)-actuator(3))^2);
        dist = [dist dis];
    end
    Homedistances = [Homedistances; dist];
    dist = [];
end

%% After Placement

Lock = [3.5,0.1,1];
AC = [2.5,1.7,2.4];
TV = [2.9,4.4,1.2];
Monitor = [3.2,3.1,1.3];
Toaster = [4.6,1.9,1.1];
Bulb = [4.4, 2.5, 2];
Heater = [2, 4.4, 0.5];
ActuatorsHome = [Lock; AC; TV; Monitor; Toaster; Bulb; Heater];

a1 = [3, 0.8, 1]; 
a2 = [5, 2.6, 1.1];
a3 = [3.8,4.6,1.5];
a4 = [1.4,4.6,0.7];

% mul = [sind(270) * cosd(225), cosd(270) * cosd(225), sind(225)]; 
mul = [sind(90) * cosd(225), cosd(90) * cosd(225), sind(225)]; 
add = 0.4*mul;
b1 = Monitor + add;

mul = [sind(45) * cosd(270), cosd(45) * cosd(270), sind(270),]; 
add = 0.5*1.5*mul;
b2 = TV + add;

b3 = [4.6,1.4,1.2];
c1 = [2.4,4.7,1.3];
c2 = [3.2,1.8,1.5];
SensorsHome = [a1; a2; a3; a4; b1; b2; b3; c1; c2];









%% Hospital 3m x 3.5m x 3m

TV = [0.2,2,1];
Alarm = [2.6,1.7,1.2];
Fan = [1,0.6,1.3];
Bulb = [1.8,2.8,1.5];
Heater = [2.4,0.6,0.5];
Actuators = [TV; Alarm; Fan; Bulb; Heater];
%%
a1 = [2.1,0.8,1];
a2 = [0.5,1.5,1];
a3 = [0.5,2.6,1.2];
b1 = [0.7,2.3,1];
b2 = [2.9, 2.6,1.3];
c1 = [1.6, 0.4,0.5];
c2 = [1.2, 2.9,1.7];
Sensors = [a1; a2; a3; b1; b2; c1; c2];

%% TV
% b1_new;
mul = [sind(0) * cosd(225), cosd(0) * cosd(225), sind(225),]; 
add = 0.5*1.3*mul;
b1_new = TV + add;

TV_dist = sqrt((TV(1)-b1_new(1))^2 + (TV(2)-b1_new(2))^2 + (TV(3)-b1_new(3))^2); %0.75
Monitor_dist = sqrt((Monitor(1)-b1_new(1))^2 + (Monitor(2)-b1_new(2))^2 + (Monitor(3)-b1_new(3))^2); %1.6
Bulb_dist = sqrt((Bulb(1)-b1_new(1))^2 + (Bulb(2)-b1_new(2))^2 + (Bulb(3)-b1_new(3))^2); %2.9
%% Fan

mul = [sind(225) * cosd(45), cosd(225) * cosd(45), sind(45),]; 
add = 0.5*1.9*mul;
a2_new = Fan + add;

%% TV

mul = [sind(0) * cosd(0), cosd(0) * cosd(0), sind(0),]; 
add = 0.4*1*mul;
a3_new = TV + add;

%%

dist = [];
Hospitaldistances = [];
for i = 1:1:5
    actuator = Actuators(i,:);
    for j = 1:1:7
        sensor = Sensors(j,:);
        % Compute distance
        dis = sqrt((sensor(1)-actuator(1))^2 + (sensor(2)-actuator(2))^2 + (sensor(3)-actuator(3))^2);
        dist = [dist dis];
    end
    Hospitaldistances = [Hospitaldistances; dist];
    dist = [];
end






%% After Placement

TV = [0.2,2,1];
Alarm = [2.6,1.7,1.2];
Fan = [1,0.6,1.3];
Bulb = [1.8,2.8,1.5];
Heater = [2.4,0.6,0.5];
Actuators = [TV; Alarm; Fan; Bulb; Heater];

a1 = [3.2,2.2,1];

mul = [sind(225) * cosd(45), cosd(225) * cosd(45), sind(45),]; 
add = 0.5*1.9*mul;
a2 = Fan + add;

mul = [sind(0) * cosd(0), cosd(0) * cosd(0), sind(0),]; 
add = 0.4*1*mul;
a3 = TV + add;

mul = [sind(0) * cosd(225), cosd(0) * cosd(225), sind(225),]; 
add = 0.5*1.3*mul;
b1 = TV + add;

b2 = [2.9, 2.6,1.3];

mul = [sind(315) * cosd(45), cosd(315) * cosd(45), sind(45),]; 
add = 0.4*1.85*mul;
c1 = Fan + add;
% c1 = [1.6, 0.4,0.5];
mul = [sind(45) * cosd(0), cosd(45) * cosd(0), sind(0),]; 
add = 0.5*2*mul;
c2 = Heater + add;
% c2 = [1.2, 2.9,1.7];
Sensors = [a1; a2; a3; b1; b2; c1; c2];



dist = [];
HospitalAfterdistances = [];
for i = 1:1:5
    actuator = Actuators(i,:);
    for j = 1:1:7
        sensor = Sensors(j,:);
        % Compute distance
        dis = sqrt((sensor(1)-actuator(1))^2 + (sensor(2)-actuator(2))^2 + (sensor(3)-actuator(3))^2);
        dist = [dist dis];
    end
    HospitalAfterdistances = [HospitalAfterdistances; dist];
    dist = [];
end

%%
info = Simulink.MDLInfo('one_actuator.mdl'); % works only in releases after R2009b
modelVer = info.SimulinkVersion

