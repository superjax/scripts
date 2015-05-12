% Grab true path, convert to UTM, plot
gps_deg = load('figs/coords.csv');
gps_utm = gps_deg;
for i = 1:size(gps_deg,1);
    [gps_x,gps_y] = deg2utm(gps_deg(i,2),gps_deg(i,1));
    gps_utm(i,:) = [gps_x,gps_y];
end
gps_utm(1,:) = gps_utm(1,:) - [-6.73 4.96];
gps = gps_utm - repmat(gps_utm(1,:),size(gps_deg,1),1);
hold on;
h_gps = plot(gps(:,1),gps(:,2),'k--','LineWidth',3);