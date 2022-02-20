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

%% Calibration for depth and angle
%number of input value
numb_depth= input('How many depths will you measure? ');
depth=zeros(1,numb_depth);
tilt_angle=zeros(1,numb_depth);

for i=1:numb_depth
    %input the depth
    depth(i)= input(['Enter the the # ' num2str(i) ' depth value to the nearest mm  ']);
    %Acelerometer will calculate and save the tilt angle respect to depth
    %input
    Vx = readaxis(a,'A0',10);
    accx = (Vx-xRawMin)/slopex;
    Vz = readaxis(a,'A2',10);
    accz = (Vz-zRawMin)/slopez;
    tilt_angle(i) = atand(accx/accz);
end
data=[tilt_angle',depth'];
% Use the third order polynomial to demonstrate relationship between depth
% and tilt angle
p = polyfit(tilt_angle,depth,3);

%Sketch data and fitting curve
xplot = linspace(min(tilt_angle),max(tilt_angle));
figure(1)
hold on
plot(tilt_angle,depth,'ob');
plot(xplot,polyval(p,xplot),'r--')
title('Cablibration fot tilt angle and depth of water');
xlabel('Angle (degree)');
ylabel('Depth (mm)');
legend('Data','fit curve');

% Show the fitting result (equation) on the figure
calibration = ['depths = ',num2str(p(1)),'*theta^3 +',num2str(p(2)),'*theta^2 +',num2str(p(3)),'*theta +',num2str(p(4)),' [Degree]'];
text(mean(tilt_angle),mean(depth),calibration);

save('Data.mat','data');
%Do curve fit
%Put calibration for the curve
%Change height to depth
%Depth is a function of angle