1%ADXL335 accelerometer calibration script
%VCC = 3.3V
%A0 = ax, A1 = ay, A2 = az
clear accz
clear figure1
%a=arduino
%Orient sensor so x,y,z = 1,0,0
cont = input('Orient sensor so x,y,z = 1,0,0.  Press 1 to continue. ')
xRawMax = readaxis(a,'A0',10);
yRawMin = readaxis(a,'A1',10);
zRawMin = readaxis(a,'A2',10);
%Orient sensor so x,y,z = 0,1,0
cont = input('Orient sensor so x,y,z = 0,1,0.  Press 1 to continue. ')
xRawMin = readaxis(a,'A0',10);
yRawMax = readaxis(a,'A1',10);
%zRawMin = readaxis(a,'A2',10);
%Orient sensor so x,y,z = 0,0,1
cont = input('Orient sensor so x,y,z = 0,0,1.  Press 1 to continue. ')
%xRawMin = readaxis(a,'A0',10);
%yRawMin = readaxis(a,'A1',10);
zRawMax = readaxis(a,'A2',10);

%Calibration Constants
slopex = (xRawMax-xRawMin);
slopey = (yRawMax-yRawMin);
slopez = (zRawMax-zRawMin);
fprintf('AccelX = (Vx - %7.4f)/%7.4f. \n',xRawMin,slopex) 
fprintf('AccelY = (Vy - %7.4f)/%7.4f. \n',yRawMin,slopey) 
fprintf('AccelZ = (Vz - %7.4f)/%7.4f. \n',zRawMin,slopez) 

cont = input('Press 1 to continue with live updated plot of g-readings. ')

figure(1)
hold on
for k = 1:50
    Vx(k) = readaxis(a,'A0',10);
    accx(k) = (Vx(k)-xRawMin)/slopex;
    Vy(k) = readaxis(a,'A1',10);
    accy(k) = (Vy(k)-yRawMin)/slopey;
    Vz(k) = readaxis(a,'A2',10);
    accz(k) = (Vz(k)-zRawMin)/slopez;
    plot(k,accx(k),'or', k,accy(k),'pg',k,accz(k),'sb')
    tilt_angle = atand(accx(k)/accy(k)) %0 degrees when y-dir is vertical
    pause(1)
end


