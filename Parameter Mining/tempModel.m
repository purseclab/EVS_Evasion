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

%% Parameter mining with time window
%temperatureParametersInit;

DiffTemp=15/1.8; %change it to other diff temp
timeCoffee=20;   %modify it other time
dc = 0; % Distance
l = 0.0;
r = 10.0;

time_window = 5;


temperatureParametersInitAC;
tempInit; 

tic
rob = 999;
temp = 0;
while l < r
    dc = (l+r)/2;
    sim('one_actuator.mdl');
    rob = dp_taliro(phi,Pred,AggTemp(1:(length(AggTemp)-1)*time_window/60 +1,1),tout(1:(length(tout)-1)*time_window/60 +1,1));
    disp(rob)
    if(rob==temp && rob < 1)
        break
    end
    temp = rob;
    if rob > 0.02
        r = dc;
    elseif rob < -0.02
        l = dc;
    else
        break
    end
end

toc
