while(1)
    Vx(k) = readaxis(a,'A0',10);
    accx(k) = (Vx(k)-xRawMin)/slopex;
    Vy(k) = readaxis(a,'A1',10);
    accy(k) = (Vy(k)-yRawMin)/slopey;
    Vz(k) = readaxis(a,'A2',10);
    accz(k) = (Vz(k)-zRawMin)/slopez;
    plot(k,accx(k),'or', k,accy(k),'pg',k,accz(k),'sb')
    tilt_angle = atand(accx(k)/accy(k)) %0 degrees when y-dir is vertical
end