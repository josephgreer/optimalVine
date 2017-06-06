function aL = aLeft(params, state, coordinate, edge, value)

r = wrapTo2Pi(coordinate(3)-params.radStep);
h = params.actuatorSpacing;
xStep = h*sin(r);
yStep = h*cos(r);
x = coordinate(1)+xStep;
y = coordinate(2)+yStep;
out = workspaceOut(params, [x,y]);
if edge && out
    aL = value(state);
else
    next_state = StateToLinear(params, [x,y,r]);
    aL = value(next_state);
end