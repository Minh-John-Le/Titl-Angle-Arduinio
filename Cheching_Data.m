load 'Data'
titlt_angle=data(:,1);
depth=data(:,2);
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