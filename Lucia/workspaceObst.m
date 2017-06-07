function obst = workspaceObst(coordinate, obstacle)

[in,on] = inpolygon(coordinate(1),coordinate(2),obstacle(:,1),obstacle(:,2));
if in || on
    obst = true;
else
    obst = false;
end