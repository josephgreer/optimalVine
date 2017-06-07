function edge = workspaceEdge(params, coordinate)

NUM_GRID = params.nGridPoints^2;
edge_state = StateToLinear(params, [coordinate(1:2) 0]);
left_edge = ~isempty(intersect(edge_state, NUM_GRID-params.nGridPoints+1:NUM_GRID));
right_edge = ~isempty(intersect(edge_state, 1:params.nGridPoints));
back_edge = ~isempty(intersect(edge_state, params.nGridPoints*(1:params.nGridPoints)));
edge = left_edge || right_edge || back_edge;