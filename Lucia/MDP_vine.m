clear; close all;

params = initParams();
NUM_STATES = params.nGridPoints^2*params.nRadPoints;
pause_time = 0.5;
load('states.mat');
load('charPolicy.mat');
destination = LinearToState(params, destination);
actions = ['S','L','R'];

x = 5.0; y = 2.0; r = 0;
state = StateToLinear(params, [x,y,r]);

set(gcf,'DoubleBuffer','on');
drawnow; hold on; grid on;
plot(destination(1), destination(2), 'cd');
angle = 0:2*pi/50:2*pi;
rad_x = destination(1)+params.successRad*cos(angle);
rad_y = destination(2)+params.successRad*sin(angle);
plot(rad_x,rad_y,'c');
axis equal;
axis([0 params.gridWidth 0 params.gridHeight]);
plot(obstacle(:,1), obstacle(:,2), '-r');
color = 'g';

for i=1:params.nActuators
    
    coordinate = LinearToState(params, state);
    plot(coordinate(1), coordinate(2), 'o', 'MarkerEdgeColor','k',...
        'MarkerSize', 10, 'MarkerFaceColor', color);
    % string = sprintf('plot_%d.png',i);
    % saveas(gcf,string);
    
    dist = (coordinate(1)-destination(1))^2+(coordinate(2)-destination(2))^2;
    if dist <= params.successRad^2
        disp('target reached')
        break
    end
    
    obst = workspaceObst(coordinate, obstacle);
    if obst
        disp('collision with obstacle')
        break
    end
    
    opt_policy = charPolicy(state);
    if opt_policy == 'L'
        r = wrapTo2Pi(coordinate(3)-params.radStep);
    elseif opt_policy == 'R'
        r = wrapTo2Pi(coordinate(3)+params.radStep);
    elseif opt_policy == 'S'
        r = coordinate(3);
    end
    xStep = params.actuatorSpacing*sin(r);
    yStep = params.actuatorSpacing*cos(r);
    x = coordinate(1)+xStep;
    y = coordinate(2)+yStep;
    opt_state = StateToLinear(params, [x,y,r]);
    opt_coordinate = LinearToState(params, opt_state);
    plot(opt_coordinate(1), opt_coordinate(2), 'bx');
    
    if params.pSuccess >= rand
        policy = opt_policy;
        color = 'b';
        a = 'success';
    else % symmetric probabilities
        policy = setdiff(actions, charPolicy(state));
        policy = policy(randi(2,1,1));
        color = 'r';
        a = 'fail';
    end
    
    if policy == 'L'
        r = wrapTo2Pi(coordinate(3)-params.radStep);
    elseif policy == 'R'
        r = wrapTo2Pi(coordinate(3)+params.radStep);
    elseif policy == 'S'
        r = coordinate(3);
    end
    xStep = params.actuatorSpacing*sin(r);
    yStep = params.actuatorSpacing*cos(r);
    x = coordinate(1)+xStep;
    y = coordinate(2)+yStep;
    state = StateToLinear(params, [x,y,r]);
    fprintf('%d: %c (%s %c)\n', i, opt_policy, a, policy)
    
    if (i==params.nActuators) && (dist>params.successRad^2)
        disp('failed to reach target')
    end
    
    pause(pause_time);
end