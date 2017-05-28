function state = StateToLinear_edit(params, state)

[gridX, gridY] = GenerateGrid(params);
[destX, destY] = findClosestPoint(params, state);
state = intersect(find(gridX==destX), find(gridY==destY));