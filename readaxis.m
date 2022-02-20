function [Vout] = readaxis(a,pin,SampleSize)
%Takes multiple voltage readings from an analog pin and returns the average
pause(0.1);
for k = 1:SampleSize
    reading(k) = readVoltage(a,pin);
end
Vout = mean(reading);
end