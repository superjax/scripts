data = processAllTopics('~/test_flight1.bag')


figure(1)
hold on
plot(data.rc_raw.time(:), data.rc_raw.values(1,:));
plot(data.rc_raw.time(:), data.rc_raw.values(2,:));
plot(data.rc_raw.time(:), data.rc_raw.values(3,:));
plot(data.rc_raw.time(:), data.rc_raw.values(4,:));
hold off