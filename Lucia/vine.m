function [] = vine(destination, state, params, pause_time)

set(gcf,'DoubleBuffer','on');

plotx(1) = state(1);
ploty(1) = state(2);

plotx(2) = state(1) + params.actuatorSpacing * cos(state(3));
ploty(2) = state(2) + params.actuatorSpacing * sin(state(3));

drawnow; hold on; grid on;
plot(plotx, ploty, 'b', 'LineWidth', 4);
plot(destination(1), destination(2), 'rd');
axis([0 params.gridWidth 0 params.gridHeight]);

pause(pause_time);