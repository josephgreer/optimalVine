function aS = aStraight(params, state, coordinate, edge, value)

r = coordinate(3);
h = params.actuatorSpacing;
xStep = h*sin(r);
yStep = h*cos(r);
x = coordinate(1)+xStep;
y = coordinate(2)+yStep;
out = workspaceOut(params, [x,y]);
if edge && out
    aS = value(state);
else
    next_state = StateToLinear(params, [x,y,r]);
    aS = value(next_state);
end