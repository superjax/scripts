data = processAllTopics('~/airspeed.bag')

figure(1); clf; hold on;
subplot(311)
plot(data.airspeed.time, data.airspeed.diff_press);
subplot(312)
plot(data.airspeed.time, data.airspeed.velocity);
subplot(313)
plot(data.airspeed.time, data.airspeed.temperature);