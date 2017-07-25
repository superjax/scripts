function [handles,labels] = plot_compounded_edges( GT, GP, GT_noise )
%PLOT_COMPOUNDED_EDGES Plots mean path, covariance, and sample paths
%   Detailed explanation goes here

xlabel('x (m)');
ylabel('y (m)');

nIters = size(GT_noise,1);
nTrans = size(GT_noise,2);

hold on;

for i = 1:nIters
    h_traj(i) = plot( 0, 0,'Color',[0.8 1 0.8]);
end
h_monte  = plot( 0, 0,'g.','MarkerSize',7,'LineWidth',1);
h_cov(1) = plot( 0, 0,'Color',[1 0 0],'MarkerSize',7,'LineWidth',1);
h_cov(2) = plot( 0, 0,'Color',[1 0 0],'MarkerSize',7,'LineWidth',1);
h_cov(3) = plot( 0, 0,'Color',[1 0 0],'MarkerSize',7,'LineWidth',1);

h_truth  = plot( 0, 0,'Color',[0 0 1],'Marker','.','MarkerSize',7,'LineWidth',1);
handles = [h_truth h_cov(1) h_traj(1)];
labels = {'Estimate','Covariance','Monte-Carlo trajectory'};

for animation_index = 1:nTrans
    
    %% Plot the random samples' trajectory lines (in a frame attached to the start)
    
    for i = 1 : nIters
        for k = 1 : animation_index
            r = GT_noise{i,k}(1:3,1:3)'*GT_noise{i,k}(1:3,4);
            x(k) = r(1);
            y(k) = r(2);
        end
        set(h_traj(i) ,'XData',-x,'YData',y);
        %set(h_cov(n)  ,'XData',clines{n}(1,:),'YData',clines{n}(2,:));
        %set(plot( x, y),'Color',[0.8 0.8 1]); % Trajectory
    end
    clear x y
    for i = 1 : nIters
        r = GT_noise{i,animation_index}(1:3,1:3)'*GT_noise{i,animation_index}(1:3,4);
        x(i) = r(1);
        y(i) = r(2);
        
        %plot( r(1), r(2),'b.'); % Final trajectory point
    end
    set(h_monte,'XData',-x,'YData',y);
    
    %% Plot mean trajectory
    for k = 1 : animation_index
        r = GT{k}(1:3,1:3)'*GT{k}(1:3,4);
        x(k) = r(1);
        y(k) = r(2);
    end
    set(h_truth,'XData',-x,'YData',y);
    %plot( x(end), y(end),'g*');
    
    %% Plot the propagated covariance in SE(3) for fourth-order method - projected onto x,y
    sigma = 3;
    [V,D] = eig(GP{animation_index}([1 2 6],[1 2 6])); %([1 2 6],[1 2 6])
    [Y,I] = sort(diag(D),'descend');
    a = sigma*sqrt( D(I(1),I(1)) );
    b = sigma*sqrt( D(I(2),I(2)) );
    c = sigma*sqrt( D(I(3),I(3)) );
    mmax = 50;
    clines = {zeros(2,mmax);zeros(2,mmax);zeros(2,mmax)};
    for m = 1 : mmax;
        v = -pi + 2*pi*(m-1)/(mmax-1);
        p{1} = a*squeeze(V(:,I(1)))*sin(v) + b*squeeze(V(:,I(2)))*cos(v);
        p{2} = b*squeeze(V(:,I(2)))*sin(v) + c*squeeze(V(:,I(3)))*cos(v);
        p{3} = a*squeeze(V(:,I(1)))*sin(v) + c*squeeze(V(:,I(3)))*cos(v);
        for n = 1:3
            Ttemp = vec2tran( [p{n}(1:2);0;0;0;p{n}(3)] )*GT{animation_index};
            r = Ttemp(1:3,1:3)'*Ttemp(1:3,4);
            clines{n}(1,m) = r(1);
            clines{n}(2,m) = r(2);
        end
    end
    for n = 1:3
        set(h_cov(n) ,'XData',-clines{n}(1,:),'YData',clines{n}(2,:));
    end

    drawnow;
end
end

