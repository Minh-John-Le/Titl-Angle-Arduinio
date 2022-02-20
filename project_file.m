clc
clear 
close

a=arduino;
%% accelerometer calibration constants
% This is the set up for acellerometer so that when x is horizontal and y is
% verticle the title angle will read as theta=0.
xRawMin=1.6422;
slopex=0.3304;
zRawMin=1.6178;
slopez=0.3177;

%% set up LED pin hole for arduino
% 8 LEDS Pin
LedPin1='D2';
LedPin2='D3';
LedPin3='D4';
LedPin4='D5';
LedPin5='D6';
LedPin6='D7';
LedPin7='D8';
LedPin8='D9';
% 2 Alarm Pin
Alarm1='D11';
Alarm2='D13';
% Switch
SwitchPin='D12';


%%
hplot=animatedline;
k = 1;

while(1)
%% measure the tilt angle
    % as x is horixontal, tilt angle will be zero
    Vx = readaxis(a,'A0',10);
    accx = (Vx-xRawMin)/slopex;
    Vz = readaxis(a,'A2',10);
    accz = (Vz-zRawMin)/slopez;
    tilt_angle = atand(accx/accz); %0 degrees when y-dir is vertical
    pause(1)
%% Measurement set up
%After the calibration for the relationship between the deep level of water and
%the title angle, we will input them as an anonymous function. Also, We
%will include the critial depth where the alarm will go off.

theta= tilt_angle;
depth = -6.321805539965791e-04*theta^3+ 0.101211085502411*theta^2-7.201782375730312*theta^1+2.245203387361281e+02

max_depth=120;
level=linspace(15,max_depth,9); %Create 8 interval of water level

%% Draw the grahp
addpoints(hplot,k,depth);
ylabel('depth (mm)');
xlabel('time');
title('change level of water depth');
drawnow

%% Alarm condition
%First alarm by code
if depth > max_depth
    writeDigitalPin(a,Alarm1,1);
else
    writeDigitalPin(a,Alarm1,0);
end 

%Second Alarm by switch

switchState=readDigitalPin(a,SwitchPin);
if switchState==0
    writeDigitalPin(a,Alarm2,0);
else 
    writeDigitalPin(a,Alarm2,1); 
end

%% Array of 8 LED will change according to the depth level of water
%turn off all LEDs
    writeDigitalPin(a,LedPin1,0);
    writeDigitalPin(a,LedPin2,0);
    writeDigitalPin(a,LedPin3,0);
    writeDigitalPin(a,LedPin4,0);
    writeDigitalPin(a,LedPin5,0);
    writeDigitalPin(a,LedPin6,0);
    writeDigitalPin(a,LedPin7,0);
    writeDigitalPin(a,LedPin8,0);
%Turn on all LEDs in the highest interval of water's depth
if depth>level(8) & depth<=level(9)
    writeDigitalPin(a,LedPin1,1);
    writeDigitalPin(a,LedPin2,1);
    writeDigitalPin(a,LedPin3,1);
    writeDigitalPin(a,LedPin4,1);
    writeDigitalPin(a,LedPin5,1);
    writeDigitalPin(a,LedPin6,1);
    writeDigitalPin(a,LedPin7,1);
    writeDigitalPin(a,LedPin8,1);
%Turn on all 7 LEDs in the 7th interval of water's depth
elseif depth>level(7) & depth<=level(8)
    writeDigitalPin(a,LedPin1,1);
    writeDigitalPin(a,LedPin2,1);
    writeDigitalPin(a,LedPin3,1);
    writeDigitalPin(a,LedPin4,1);
    writeDigitalPin(a,LedPin5,1);
    writeDigitalPin(a,LedPin6,1);
    writeDigitalPin(a,LedPin7,1);  
%Turn on all 6 LEDs in the 6th interval of water's depth
elseif depth>level(6) & depth<=level(7)
    writeDigitalPin(a,LedPin1,1);
    writeDigitalPin(a,LedPin2,1);
    writeDigitalPin(a,LedPin3,1);
    writeDigitalPin(a,LedPin4,1);
    writeDigitalPin(a,LedPin5,1);
    writeDigitalPin(a,LedPin6,1);
%Turn on all 5 LEDs in the 5th interval of water's depth
elseif depth>level(5) & depth<=level(6)
    writeDigitalPin(a,LedPin1,1);
    writeDigitalPin(a,LedPin2,1);
    writeDigitalPin(a,LedPin3,1);
    writeDigitalPin(a,LedPin4,1);
    writeDigitalPin(a,LedPin5,1);
%Turn on all 4 LEDs in the 4th interval of water's depth
elseif depth>level(4) & depth<=level(5)
    writeDigitalPin(a,LedPin1,1);
    writeDigitalPin(a,LedPin2,1);
    writeDigitalPin(a,LedPin3,1);
    writeDigitalPin(a,LedPin4,1);
%Turn on all 3 LEDs in the 3rd interval of water's depth   
elseif depth>level(3) & depth<=level(4)
    writeDigitalPin(a,LedPin1,1);
    writeDigitalPin(a,LedPin2,1);
    writeDigitalPin(a,LedPin3,1);
%Turn on all 2 LEDs in the 2nd interval of water's depth      
elseif depth>level(2) & depth<=level(3)
    writeDigitalPin(a,LedPin1,1);
    writeDigitalPin(a,LedPin2,1);
%Turn on all 1 LEDs in the first interval of water's depth          
else
    writeDigitalPin(a,LedPin1,1);
end

k = k+1; %Increase count for x value of the graph

end



