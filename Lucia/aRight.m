function aR = aRight(params, state, coordinate, edge, value)

r = wrapTo2Pi(coordinate(3)+params.radStep);
h = params.actuatorSpacing;
xStep = h*sin(r);
yStep = h*cos(r);
x = coordinate(1)+xStep;
y = coordinate(2)+yStep;
out = workspaceOut(params, [x,y]);
if edge && out
    aR = value(state);
else
    next_state = StateToLinear(params, [x,y,r]);
    aR = value(next_state);
end